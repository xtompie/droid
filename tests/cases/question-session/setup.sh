d=.ai/droids/security
mkdir -p $d/inbox
printf 'name=security\ndescription=security droid\ncreated=2026-01-01\n' > $d/droid.ini
printf '# security\n\nKeeps security knowledge.\n\n## Responsible for\n- security\n\n## Not responsible for\n- other topics\n\n## Reads\n- nothing\n' > $d/droid.md
printf '# security\n' > $d/index.md
# A throwaway socket that stands for the asking session; never a real Claude session.
sock="$PWD/.reply.sock"
nohup perl "$PEER" "$sock" "$PWD/.reply.log" >/dev/null 2>&1 &
pid=$!
echo $pid > .reply.pid
sleep 1
id=11111111-2222-4333-8444-555555555555
printf '{"pid":%s,"sessionId":"%s","messagingSocketPath":"%s","kind":"interactive"}\n' "$pid" "$id" "$sock" > "$FAKE_SESSIONS/$pid.json"
printf 'From: session\nTo: security\nReply-To: session:%s\n\nAdd the new upload size limit to your rules.\n' "$id" > $d/inbox/20260101-0900.upload-limit.md
