#!btred -T -e main()

use strict;
use warnings;
require "$ENV{'A2T'}/4/macros/comm4.pl";

use vars qw($this $root);

my $fout;

#======================================================================

sub file_opened_hook
{
	my $foutname = &FileName();
	$foutname =~ s/\.[^\/]*$/\.4i.tbl/;
	open $fout, ">:encoding(iso-8859-2)", $foutname or die "Cannot open the file $foutname\n";
}

#======================================================================

sub file_close_hook
{
	close $fout if $fout;
}

#======================================================================

sub main
{
	for (my $t_node = $root->following; $t_node; $t_node = $t_node->following)
	{
		my @t_par = &PML_T::GetEParents($t_node); # t-parents of the node
		$t_par[0] or @t_par = ($t_node->parent);

		print $fout $t_node->{'functor'}, " ", &aid($t_node)? 1:0, " ", &PML_T::IsFiniteVerb($t_par[0]), " ";

		# tag of the node
		my $m_tag = "";
		my $a_node = undef;
		if (&aid($t_node)) {
			$a_node = &PML_T::GetANodeByID(&aid($t_node));
			$m_tag = $a_node->attr('m/tag');
		}
		print $fout &tag_4p_node($m_tag);

		# tag of the parent
		$m_tag = "";
		if (&aid($t_par[0])) {
			my $a_par = &PML_T::GetANodeByID(&aid($t_par[0]));
			$m_tag = $a_par->attr('m/tag') if $a_par ne $a_par->root;
		}
		print $fout &tag_4p_par($m_tag);

		# synsemantic words
		my @syn_lemmas = map {&adjust_lemma(&PML_T::GetANodeByID($_)->attr('m/lemma'))} &ListV($t_node->attr('a/aux.rf'));
		for (0..2) {
			print $fout defined $syn_lemmas[$_]? $syn_lemmas[$_] : '--';
			print $fout " ";
		}
		
		# initial values of classes
		printf $fout "%s %s %s %s %s ",
			"---",
			&aid($t_node)? &adjust_lemma($a_node->attr('m/lemma')) : "---",
			"---",
			"---",
			"---";

		# void values of classes
		printf $fout "--- --- --- --- ---\n",
	}
}

