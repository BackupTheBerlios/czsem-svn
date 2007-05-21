
use strict;
use warnings;
require "$ENV{'A2T'}/macros/common.pl";

#my @func = qw( ACMP ACT ADDR ADVS AIM APP APPS ATT AUTH BEN CAUS CM CNCS COMPL COND CONFR CONJ CONTRA CONTRD CPHR CPR CRIT CSQ DENOM DIFF DIR1 DIR2 DIR3 DISJ DPHR EFF EXT FPHR GRAD HER ID INTF INTT LOC MANN MAT MEANS MOD OPER ORIG PAR PARTL PAT PREC PRED REAS REG RESL RESTR RHEM RSTR SUBS TFHL TFRWH THL THO TOWH TPAR TSIN TTILL TWHEN VOCAT ); # all the functors

use vars qw(@func);

@func = qw( ACMP ACT ADDR APP BEN CAUS CM CPHR CPR DIR1 DIR2 DIR3 DPHR EFF EXT ID LOC MANN MAT ORIG PAT PRED RHEM RSTR TFRWH TOWH TWHEN ); # jen uzly, ktere v trenovacich datech jsou generovane a nemaji deti (a jsou takove alespon 2x)


#======================================================================

sub tag3
{
	my ($tag) = @_;
	my $ret = "";
	$tag ne "" or $tag = '#' x 15;
	my @t = split //, $tag;
	for (0, 10, 11) {
		$ret .= $t[$_] . " ";
	}
	return $ret;
}

#======================================================================
# Gets list of real children of the node. When children are in a coordination,
# it returns the coordination node. E.g. in case of sentence "Petr umyl hrnce a
# kastroly a zametl." nodes "Petr" and "a" (connecting "hrnce a kastroly") are
# returned for node "umyl". Besides, it fills attribute eff_func of real 
# children with their effective functor (e.g. eff_func of that "a" is PAT).

sub real_children
{
	my ($node) = @_;
	my @children;
	$node or die "Assertion failed";
	for my $ch (&PML_T::GetEChildren($node)) {
		my $nearest = &PML_T::GetNearestNonMember($ch);
		$nearest->{'eff_func'} = $ch->{'functor'} unless defined $nearest->{'eff_func'};
		$nearest->{'eff_func'} eq $ch->{'functor'} or $nearest->{'eff_func'} = '???';
		push @children, $nearest unless grep { $_ eq $nearest } @children;
	}
	return @children;
}

#======================================================================

sub morph_real
{
	my ($node) = @_;
	$node = (&PML_T::ExpandCoord($node))[0] if &PML_T::IsCoord($node);
	my $a_lex = &PML_T::GetANodeByID($node->attr('a/lex.rf'));
	$a_lex or return undef;
	my @ret = ();
	for (&PML_T::ListV($node->attr('a/aux.rf')))
	{
		my $a_aux = &PML_T::GetANodeByID($_);
		$a_aux or die "Assertion failed";
		push @ret, &adjust_lemma($a_aux->attr('m/lemma')) if $a_aux->attr('m/tag') =~ /^[NJR]/;
	}
	my $case = substr($a_lex->attr('m/tag'), 4, 1);
	my $ret = join '+', sort @ret;
	return ($ret? $ret.'+' : "") . substr($a_lex->attr('m/tag'), 0, 1).($case =~ /[1-7]/? $case : "");
}

#======================================================================

1;

