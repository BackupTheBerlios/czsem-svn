
use strict;
use warnings;
require "$ENV{'A2T'}/macros/common.pl";


sub iscoord
{
	return $_[0]->{'afun'} =~ /Apos|Coord/;
}

sub eparents
{
	my ($node) = @_;
	# get the highest node representing the given node
	while (($node->{'is_member'} || (!&iscoord($node) && grep { $_->{'is_member'} && !&iscoord($_) } $node->children)) && &iscoord($node->parent)) { $node = $node->parent }
	my $par = $node->parent; # get the highest node representing its parent
	while (&iscoord($par) && $par->{'is_member'}) { $par = $par->parent }
	my @pars = &PML_A::ExpandCoord($par);
	return @pars > 0? @pars : ($node->parent); # if fails to find the e-parent
}

sub feature_string
{
	my ($a_node, $a_par) = @_;
	return sprintf "%s %s %s %s %s %s",
		&adjust_lemma($a_node->attr('m/lemma')),
		$a_node->{'afun'},
		&tag($a_node->attr('m/tag')),
		&adjust_lemma($a_par->attr('m/lemma')),
		$a_par->{'afun'},
		&tag($a_par->attr('m/tag'));
}


1;

