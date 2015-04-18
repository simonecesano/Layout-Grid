use strict;
use warnings;
package Layout::Grid;

use Moose;
use Moose::Util::TypeConstraints;
use List::MoreUtils qw/zip/;

has 'block_w' => ( is => 'rw', isa => 'Num' );
has 'block_h' => ( is => 'rw', isa => 'Num' );

has 'h_gutter' => ( is => 'rw', isa => 'Num', default => 0 );
has 'v_gutter' => ( is => 'rw', isa => 'Num', default => 0 );
has 'gutter' => (
		 is => 'rw', isa => 'Num', default => 0,
		 trigger => sub {
		     my ($self, $gutter) = @_;
		     $self->h_gutter($gutter);
		     $self->v_gutter($gutter);
		 }
		);

has 'h_blocks' => ( is => 'rw', isa => 'Int' );
has 'v_blocks' => ( is => 'rw', isa => 'Int' );

has 'sequence' => ( is => 'rw', isa => enum([qw/v h/]), default => 'h' );

sub h_block_list { return (0..shift->h_blocks-1) }
sub v_block_list { return (0..shift->v_blocks-1) }

sub position {
    my ($self, $x_pos, $y_pos) = @_;

    my $x = $self->block_w * $x_pos + $self->h_gutter * $x_pos;
    my $y = $self->block_h * $y_pos + $self->v_gutter * $y_pos;

    return ($x, $y)
}

sub block_numbers {
    my $self = shift;
    my @p;
    my ($s_a, $s_b) = $self->sequence eq 'v' ? qw/h_block_list v_block_list/ : qw/v_block_list h_block_list/;
    for my $a ($self->$s_a) { for my $b ($self->$s_b) { push @p, [$a, $b] } }
    if ($self->sequence eq 'v') { @p = map { [ reverse @$_ ] } @p} 
    return @p
}

sub all_positions {
    my $self = shift;
    my @p = $self->block_numbers;
    @p = map { [ $self->position($_->[1], $_->[0]) ] } @p; # position is row, column, coordinates are x, y
    return @p;
}

sub fit_in {
    my ($self, $w, $h, $adapt) = @_;

    $w += $self->h_gutter; $h += $self->v_gutter;
    
    ($w, $h) = (int($w / ($self->block_w + $self->h_gutter)),
		int($h / ($self->block_h + $self->v_gutter)));
    
    if ($adapt) { $self->h_blocks($w); $self->v_blocks($h) }

    return wantarray ? ($w, $h) : $w * $h;
}

sub total_size {
    my $self = shift;
    my ($w, $h) = $self->position($self->h_blocks - 1, $self->v_blocks - 1);
    return ($w + $self->block_w, $h + $self->block_h)
}


1;
