i=$1/.ai/droids/security/inbox
n=$(ls $i | wc -l | tr -d ' ')
[ "$n" = 2 ] || { echo "inbox changed: $n files"; exit 1; }
grep -qi 'rotate' "$2" || { echo "answer misses the key rotation task"; exit 1; }
grep -qi 'login' "$2" || { echo "answer misses the login review task"; exit 1; }
exit 0
