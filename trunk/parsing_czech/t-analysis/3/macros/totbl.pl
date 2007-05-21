#!btred -T -e main()

use strict;
use warnings;
require "$ENV{'A2T'}/3/macros/comm3.pl";

use vars qw($this $root);

use vars qw(@func);

my @uniq = ('a'..'z', 'A'..'Z');

my $fout;

#======================================================================

sub file_opened_hook
{
	my $foutname = &FileName();
	$foutname =~ s/\.[^\/]*$/\.3i.tbl/;
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
	my %before = (); # info about children in the files: 
	                 #   { parent's aid }{ child's functor }-> # of such cases

	for (my $t_node = $root->following; $t_node; $t_node = $t_node->following)
	{
		next if $t_node->{'is_generated'} || &PML_T::IsCoord($t_node); # generated parents and coordinations are ignored
		defined $t_node->{'t_lemma'} or die "Assertion failed";

		for my $ch (&real_children($t_node)) {
			$before{ &aid($t_node) }{ $ch->{'eff_func'} }++;
		}

		# printing of training data
		print $fout $t_node->{'t_lemma'}, " "; # print t-lemma
		my $a_node = &PML_T::GetANodeByID(&aid($t_node));
		$a_node or die "Assertion failed ($t_node->{'id'})";
		print $fout &tag3( $a_node->attr('m/tag') ); # print features other than functors
		my @t_pars = &PML_T::GetEParents($t_node);
		@t_pars && $t_pars[0] or @t_pars = ($t_node->parent);
		my $a_par = &PML_T::GetANodeByID(&aid($t_pars[0]));
		printf $fout "%s %s %s ", 
			&morph_real($t_node),
			$t_pars[0]->{'t_lemma'}? $t_pars[0]->{'t_lemma'} : '######', 
			$a_par && $a_par->attr('m/tag')? substr($a_par->attr('m/tag'), 11, 1) : '#';
		print $fout "--- "; # valency frame
		print $fout "$t_node->{'functor'} "; # current functor
		no warnings 'uninitialized';
		for my $i (0..@func-1) { # print input functors
			printf $fout "%d%s ", $before{ &aid($t_node) }{ $func[$i] }, $uniq[$i];
		}
		use warnings 'uninitialized';
		print $fout "--- "; # true valency frame
		print $fout "--- "; # true functor
		no warnings 'uninitialized';
		for my $i (0..@func-1) { # print true functors
			printf $fout "-%s ", $uniq[$i];
		}
		use warnings 'uninitialized';
		print $fout "\n";

	}
}

