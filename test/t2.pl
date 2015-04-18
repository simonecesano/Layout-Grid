use FindBin;
use lib "$FindBin::Bin/../lib";
use Layout::Grid;
use Data::Dump qw/dump/;

$\ = "\n"; $, = "\t";

my $l = Layout::Grid->new(block_w => 40, block_h => 60, h_blocks => 4, v_blocks => 3, h_gutter => 10, v_gutter => 5  );

# print dump $l->block_numbers;

# print dump $l->all_positions;

$l->sequence('v');
my $t = '<rect x="50.2" y="70.1" fill="#00B3EC" stroke-miterlimit="10" transform="translate(%d, %d)" width="40" height="40"/>';

# print dump $l->block_numbers;

for ($l->all_positions) {
    printf "$t\n", @$_ 
};

# print $l->total_size;

# print $l->fit_in(60, 36, 1);

# print scalar $l->fit_in(60, 36, 1);

# print $l->total_size;

# print dump $l->all_positions;
