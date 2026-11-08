i=$1/.ai/droids/security/inbox
n=$(ls $i | wc -l | tr -d ' ')
[ "$n" = 1 ] || { echo "expected 1 inbox file, got $n"; exit 1; }
f=$(ls $i)
grep -q '^From:' $i/$f || { echo "no From:"; exit 1; }
grep -q '^To: security' $i/$f || { echo "no To: security"; exit 1; }
grep -qi 'cookie' $i/$f || { echo "task text missing"; exit 1; }
grep -q '"name":"SendMessage"' "$3" && { echo "queue must not ping"; exit 1; }
grep -Eq 'nohup|claude -p' "$3" && { echo "queue must not wake the droid"; exit 1; }
exit 0
