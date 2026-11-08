i=$1/.ai/droids/security/inbox
n=$(ls $i | wc -l | tr -d ' ')
[ "$n" = 1 ] || { echo "expected 1 inbox file, got $n"; exit 1; }
f=$(ls $i)
echo "$f" | grep -Eq '^[0-9]{8}-[0-9]{4}\.[a-z0-9]+(-[a-z0-9]+)*\.md$' || { echo "bad file name: $f"; exit 1; }
grep -q '^From:' $i/$f || { echo "no From:"; exit 1; }
grep -q '^To: security' $i/$f || { echo "no To: security"; exit 1; }
grep -qi 'rate limit' $i/$f || { echo "question missing"; exit 1; }
grep -q '^Reply-To: session:' $i/$f || { echo "no Reply-To from a plain session"; exit 1; }
started=$(perl -MJSON::PP -ne 'my $j = eval { decode_json($_) } or next; for my $c (@{ $j->{message}{content} // [] }) { next unless ref $c eq "HASH" && ($c->{type} // "") eq "tool_use" && ($c->{name} // "") eq "Bash"; print "x" if ($c->{input}{command} // "") =~ /nohup|claude -p|--bg/ }' "$3")
[ -z "$started" ] || { echo "tried to start a claude process"; exit 1; }
grep -q 'claude "/dt-wake security"' "$2" || { echo "answer lacks the start command"; exit 1; }
exit 0
