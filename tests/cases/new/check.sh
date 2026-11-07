d=$1/.ai/droids/security
[ -f $d/droid.ini ] || { echo "no droid.ini"; exit 1; }
grep -q '^name=security$' $d/droid.ini || { echo "droid.ini: name"; exit 1; }
grep -q '^description=.' $d/droid.ini || { echo "droid.ini: description"; exit 1; }
grep -q '^created=[0-9]\{4\}-[0-9][0-9]-[0-9][0-9]$' $d/droid.ini || { echo "droid.ini: created"; exit 1; }
for h in '## Responsible for' '## Not responsible for' '## Reads'; do grep -q "^$h" $d/droid.md || { echo "droid.md: missing $h"; exit 1; }; done
[ -f $d/index.md ] || { echo "no index.md"; exit 1; }
[ -d $d/inbox ] || { echo "no inbox/"; exit 1; }
grep -rq ZEBRA-MARKER-7 $d && { echo "copied text from docs"; exit 1; }
[ -f $d/session.ini ] || { echo "not loaded: no session.ini"; exit 1; }
exit 0
