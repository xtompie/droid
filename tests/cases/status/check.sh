grep -i 'security' "$2" | grep -q '1' || { echo "security row without 1 task"; exit 1; }
grep -i 'docs' "$2" | grep -q '0' || { echo "docs row without 0 tasks"; exit 1; }
exit 0
