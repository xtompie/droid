d=.ai/droids/security
mkdir -p $d/inbox
printf 'name=security\ndescription=Security rules and dependency risks\ncreated=2026-01-01\n' > $d/droid.ini
printf '# security\n' > $d/droid.md
printf '# security\n' > $d/index.md
# The droid's session was resumed: same id, new process and socket, known only to the registry.
sock="$PWD/.droid.sock"
nohup perl -MIO::Socket::UNIX -e 'my $s = IO::Socket::UNIX->new(Type => SOCK_STREAM(), Local => shift, Listen => 1) or die; alarm 900; while (my $c = $s->accept) { close $c }' "$sock" >/dev/null 2>&1 &
pid=$!
echo $pid > .droid.pid
sleep 1
id=22222222-3333-4444-8555-666666666666
printf 'session=%s\n' "$id" > $d/session.ini
printf '{"pid":%s,"sessionId":"%s","messagingSocketPath":"%s","kind":"interactive"}\n' "$pid" "$id" "$sock" > "$DROID_SESSIONS_DIR/$pid.json"
# A stale entry for the same id, left by a process that crashed: its pid is dead.
sh -c 'exit 0' & dead=$!
wait $dead
printf '{"pid":%s,"sessionId":"%s","messagingSocketPath":"%s/.stale.sock","kind":"interactive"}\n' "$dead" "$id" "$PWD" > "$DROID_SESSIONS_DIR/0$dead.json"
