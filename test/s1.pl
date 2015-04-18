my $h = 4;
my $v = 3;

$\ = "\n"; $, = "\t";

for my $a (0..$h-1) {
    for $b (0..$v-1) {
	print $a, $b
    }
}

print '#' x 20;

for my $a (0..$v-1) {
    for $b (0..$h-1) {
	print $b, $a
    }
}
