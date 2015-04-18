use FindBin;
use lib "$FindBin::Bin/../lib";
use Layout::Grid;
use Data::Dump qw/dump/;

$\ = "\n"; $, = "\t";

my $l = Layout::Grid->new(block_w => 10, block_h => 10, h_blocks => 4, v_blocks => 3, gutter => 2 );

# print dump $l->block_numbers;

print dump $l->all_positions;

$l->sequence('v');

# print dump $l->block_numbers;

print @$_ for $l->all_positions;

# print $l->total_size;

# print $l->fit_in(60, 36, 1);

# print scalar $l->fit_in(60, 36, 1);

# print $l->total_size;

# print dump $l->all_positions;
