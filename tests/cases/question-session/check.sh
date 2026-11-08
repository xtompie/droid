kill "$(cat $1/.reply.pid 2>/dev/null)" 2>/dev/null
s=$1/.ai/droids/security/inbox/20260101-0900.upload-limit.md
[ -f "$s" ] || { echo "original task was deleted"; exit 1; }
grep -q '^Waiting for:' "$s" || { echo "no Waiting for: line in the original task"; exit 1; }
sock="$(basename "$1")/.reply.sock"
perl "$(dirname "$0")/../../sendmessage-to.pl" "$3" | grep -q "$sock" || { echo "no SendMessage to the looked-up socket"; exit 1; }
exit 0
