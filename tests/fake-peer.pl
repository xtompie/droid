# A stand-in for a live Claude Code session: listens on a messaging socket, reads each
# message like a real peer does and appends it to a log. Usage: perl fake-peer.pl <socket> <log>
use IO::Socket::UNIX;
my ($path, $log) = @ARGV;
my $s = IO::Socket::UNIX->new(Type => SOCK_STREAM(), Local => $path, Listen => 5) or die "listen $path: $!";
alarm 900;
open my $l, '>>', $log or die;
$l->autoflush(1);
while (my $c = $s->accept) {
    $c->blocking(0);
    my $buf = '';
    for (1 .. 20) {
        my $n = sysread($c, my $chunk, 65536);
        $buf .= $chunk if $n;
        select(undef, undef, undef, 0.1);
    }
    print $l $buf, "\n";
    close $c;
}
