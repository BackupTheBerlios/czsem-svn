#!btred -T -e main()

use strict;
use warnings;
require "$ENV{'A2T'}/4/macros/comm4.pl";

use vars qw($this $root);

my $ftbl;

#======================================================================

sub file_opened_hook
{
	my $ftblname = &FileName();
	$ftblname =~ s/\.[^\/]*$/\.4o.tbl/;
	open $ftbl, "<:encoding(iso-8859-2)", $ftblname or die "Cannot open the file $ftblname\n";
	&ChangingFile(1);
}

#======================================================================

sub file_close_hook
{
	close $ftbl if $ftbl;
}

#======================================================================

sub main 
{
	for (my $t_node = $root->following; $t_node; $t_node = $t_node->following) {
		my $line;
		defined ($line = <$ftbl>) or die "Unexpected end of file";
		$line =~ s/(.*)\| ([0-9]+ )*$/$1/; # strip rule' numbers
		$line =~ /^(\S+) (\S+) (\S+ ){7}(\S+) (\S+) (\S+) (\S+) (\S+)/ or die "Bad line in the input file: \"$line\"";
		$1 eq $t_node->{'functor'} or die "The input files do not match ($1 vs. $t_node->{'functor'})";

		$t_node->{'t_lemma'} = $2? $5 : $4;
		$t_node->{'nodetype'} = $6 if $6 ne '---';
		$t_node->{'gram'}{'sempos'} = $7 if $7 ne '---';
		$t_node->{'subfunctor'} = $8 if $8 ne '---';
	}
}

