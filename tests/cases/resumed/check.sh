kill "$(cat $1/.droid.pid 2>/dev/null)" 2>/dev/null
n=$(ls $1/.ai/droids/security/inbox | wc -l | tr -d ' ')
[ "$n" = 1 ] || { echo "expected 1 inbox file, got $n"; exit 1; }
sock="$(basename "$1")/.droid.sock"
perl "$(dirname "$0")/../../sendmessage-to.pl" "$3" | grep -q "$sock" || { echo "no ping to the live socket from the registry"; exit 1; }
grep -q 'New message in inbox' "$1/.droid.log" 2>/dev/null || { echo "the live session did not receive the ping"; exit 1; }
woke=$(perl -MJSON::PP -ne 'my $j = eval { decode_json($_) } or next; for my $c (@{ $j->{message}{content} // [] }) { next unless ref $c eq "HASH" && ($c->{type} // "") eq "tool_use" && ($c->{name} // "") eq "Bash"; print "x" if ($c->{input}{command} // "") =~ /claude -p|nohup/ }' "$3")
[ -z "$woke" ] || { echo "started a background wake although the droid is alive"; exit 1; }
exit 0
