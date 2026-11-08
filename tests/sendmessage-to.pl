# Prints the recipients of every SendMessage call in a claude -p stream-json file.
use JSON::PP;
while (<>) {
    my $j = eval { decode_json($_) } or next;
    for my $c (@{ $j->{message}{content} // [] }) {
        next unless ref $c eq 'HASH' && ($c->{type} // '') eq 'tool_use' && ($c->{name} // '') eq 'SendMessage';
        my $i = $c->{input} // {};
        print(($i->{recipient} // $i->{to} // ''), "\n");
    }
}
