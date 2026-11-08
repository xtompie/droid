d=$1/.ai/droids/security
n=$(ls $d/inbox | wc -l | tr -d ' ')
[ "$n" = 0 ] || { echo "inbox not empty ($n)"; exit 1; }
page=$(grep -l '10 MB' $d/*.md 2>/dev/null | grep -Ev '/(index|droid)\.md$' | head -1)
[ -n "$page" ] || { echo "no wiki page with the rule"; exit 1; }
grep -q "$(basename $page)" $d/index.md || { echo "index.md does not list $(basename $page)"; exit 1; }
[ -f $d/session.ini ] || { echo "not loaded: no session.ini"; exit 1; }
exit 0
