#!/bin/sh
# Live tests: each case runs a real Claude Code session (claude -p) in a fresh temp project
# with the skills installed under the prefix "dt", then checks the files and the answer.
# Usage: tests/run.sh [case-id] [--runs N] [--model haiku|sonnet]
set -u

ROOT=$(cd "$(dirname "$0")/.." && pwd)
CASES="$ROOT/tests/cases"
RUNS=1
MODEL=haiku
ONLY=""
TIMEOUT=600
DEFAULT_TOOLS='Read Write Edit Glob Grep SendMessage Bash(ps:*) Bash(echo:*) Bash(ls:*) Bash(date:*) Bash(mkdir:*) Bash(rm:*) Bash(git rev-parse:*)'

while [ $# -gt 0 ]; do
    case "$1" in
        --runs) RUNS=$2; shift 2 ;;
        --model) MODEL=$2; shift 2 ;;
        -h|--help) sed -n '2,4p' "$0"; exit 0 ;;
        *) ONLY=$1; shift ;;
    esac
done

command -v claude >/dev/null 2>&1 || { echo "claude not found"; exit 2; }

PATTERN='droid-\(new\|clone\|status\|load\|tasks\|work\|send\|save\|lint\|destroy\)'

install() { # project dir
    p=$1
    mkdir -p "$p/.ai/droids" "$p/.claude/skills"
    sed "s/$PATTERN/dt-\1/g" "$ROOT/core/droids.md" > "$p/.ai/droids/droids.md"
    for d in "$ROOT"/skills/droid-*; do
        n=$(basename "$d" | sed 's/^droid-/dt-/')
        mkdir -p "$p/.claude/skills/$n"
        sed "s/$PATTERN/dt-\1/g" "$d/SKILL.md" > "$p/.claude/skills/$n/SKILL.md"
    done
    printf '.ai/droids/*/session.ini\n' > "$p/.gitignore"
}

total_fail=0
for dir in "$CASES"/*/; do
    id=$(basename "$dir")
    [ -n "$ONLY" ] && [ "$id" != "$ONLY" ] && continue
    pass=0
    i=1
    while [ "$i" -le "$RUNS" ]; do
        p=$(mktemp -d "${TMPDIR:-/tmp}/droid-test.XXXXXX")
        (cd "$p" && git init -q)
        install "$p"
        [ -f "$dir/setup.sh" ] && (cd "$p" && env -u CLAUDE_CODE_MESSAGING_SOCKET -u CLAUDE_CODE_SESSION_ID -u CLAUDE_PID sh "$dir/setup.sh")
        tools=$DEFAULT_TOOLS
        [ -f "$dir/allowed-tools" ] && tools=$(cat "$dir/allowed-tools")
        stream="$p.stream"
        # shellcheck disable=SC2086
        (cd "$p" && env -u CLAUDE_CODE_MESSAGING_SOCKET -u CLAUDE_CODE_MESSAGING_TOKEN -u CLAUDE_CODE_SESSION_ID -u CLAUDE_PID \
            perl -e 'alarm shift; exec @ARGV' "$TIMEOUT" \
            claude -p "$(cat "$dir/prompt.md")" --model "$MODEL" --output-format stream-json --verbose \
            --allowedTools $tools) > "$stream" 2>&1
        out="$p.out"
        perl -CS -MJSON::PP -ne 'my $j = eval { decode_json($_) } or next; print $j->{result} if ($j->{type} // "") eq "result"' "$stream" > "$out"
        cmd=$(sed -n '1s#^/\(dt-[a-z]*\).*#\1#p' "$dir/prompt.md")
        if [ -n "$cmd" ] && ! grep -q "\"$cmd\"" "$stream"; then
            reason="skill $cmd not installed in the test project"
            ok=1
        else
            reason=$(sh "$dir/check.sh" "$p" "$out" "$stream" 2>&1)
            ok=$?
        fi
        if [ "$ok" -eq 0 ]; then
            pass=$((pass + 1))
            echo "$id #$i pass"
        else
            echo "$id #$i fail $reason"
        fi
        rm -rf "$p" "$stream" "$out"
        i=$((i + 1))
    done
    need=$(( (2 * RUNS + 2) / 3 ))
    echo "$id $pass/$RUNS"
    [ "$pass" -lt "$need" ] && total_fail=1
done
exit $total_fail
