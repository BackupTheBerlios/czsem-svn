
use strict;
use warnings;
require "$ENV{'A2T'}/macros/common.pl";

# assistant function
sub feature_touple
{
	my ($t_node) = @_;
	my $a_node = &PML_T::GetANodeByID(&aid($t_node));
	$a_node or die "Assertion failed";
	return (
		&adjust_lemma($a_node->attr('m/lemma')),
		&tag_2ch($a_node->attr('m/tag')),
		$a_node->{'afun'},
		$t_node ne $t_node->root? $t_node->{'functor'} : '###'
		);
}

# assistant function
sub compound_feature
{
	my @c_feat = ();
	my @outarr = ();
	while (my $node = shift @_)
	{
		my @f = &feature_touple($node);
		for my $i (0..3) { push @{$c_feat[$i]}, $f[$i] }
	}
	for my $i (0..3)
	{
		push @outarr, ($c_feat[$i]? (join '+', @{$c_feat[$i]}) : '---');
	}
	return @outarr;
}
	

sub feature_string
{
	my ($t_node) = @_;
	my $outstr = "";
	my @list;

	$outstr = sprintf "%s %s %s %s  %s %s %s %s ", &feature_touple($t_node), &feature_touple($t_node->parent);
	for (@list = (), my $n = $t_node->rbrother; $n; $n = $n->rbrother) { push @list, $n }
	$outstr .= sprintf " %s %s %s %s ", &compound_feature(@list);
	for (@list = (), my $n = $t_node->lbrother; $n; $n = $n->lbrother) { push @list, $n }
	$outstr .= sprintf " %s %s %s %s ", &compound_feature(@list);
	$outstr .= sprintf " %s %s %s %s", &compound_feature($t_node->children);
	return $outstr;
}


1;

