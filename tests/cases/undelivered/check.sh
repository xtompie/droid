s=$1/.ai/droids/security/inbox/20260101-0900.upload-limit.md
[ -f "$s" ] || { echo "task with an undeliverable answer was deleted"; exit 1; }
grep -q '^Undelivered:' "$s" || { echo "no Undelivered: line"; exit 1; }
grep -q '20' "$s" || { echo "the answer is not in the file"; exit 1; }
exit 0
