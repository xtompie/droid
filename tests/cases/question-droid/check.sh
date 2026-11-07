s=$1/.ai/droids/security/inbox/20260101-0900.upload-limit.md
[ -f "$s" ] || { echo "original task was deleted"; exit 1; }
grep -q '^Waiting for:' "$s" || { echo "no Waiting for: line in the original task"; exit 1; }
q=$(grep -l '^From: security' $1/.ai/droids/docs/inbox/*.md 2>/dev/null | head -1)
[ -n "$q" ] || { echo "no question in docs inbox"; exit 1; }
grep -q '^To: docs' "$q" || { echo "question has no To: docs"; exit 1; }
exit 0
