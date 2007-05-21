
use strict;
use warnings;
require "$ENV{'A2T'}/macros/common.pl";

#======================================================================

sub tag_4p_par
{
	my ($tag) = @_;
	my $ret = "";
	$tag ne "" or $tag = '#' x 15;
	my @t = split //, $tag;
	for (1, 10) {
		$ret .= $t[$_] . " ";
	}
	return $ret;
}

#======================================================================

sub tag_4p_node
{
	my ($tag) = @_;
	my $ret = "";
	$tag ne "" or $tag = '#' x 15;
	my @t = split //, $tag;
	for (1) {
		$ret .= $t[$_] . " ";
	}
	return $ret;
}

#======================================================================

1;

