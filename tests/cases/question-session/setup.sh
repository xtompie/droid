d=.ai/droids/security
mkdir -p $d/inbox
printf 'name=security\ndescription=security droid\ncreated=2026-01-01\n' > $d/droid.ini
printf '# security\n\nKeeps security knowledge.\n\n## Responsible for\n- security\n\n## Not responsible for\n- other topics\n\n## Reads\n- nothing\n' > $d/droid.md
printf '# security\n' > $d/index.md
# A throwaway socket that stands for the asking session; never a real Claude session.
sock="$PWD/.reply.sock"
nohup perl -MIO::Socket::UNIX -e 'my $s = IO::Socket::UNIX->new(Type => SOCK_STREAM(), Local => shift, Listen => 1) or die; alarm 900; while (my $c = $s->accept) { close $c }' "$sock" >/dev/null 2>&1 &
echo $! > .reply.pid
sleep 1
printf 'From: session\nTo: security\nReply-To: uds:%s\n\nAdd the new upload size limit to your rules.\n' "$sock" > $d/inbox/20260101-0900.upload-limit.md
