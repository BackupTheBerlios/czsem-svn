#!btred -T -e main()

use strict;
use warnings;
require "$ENV{'A2T'}/1/macros/comm1.pl";

use vars qw($this $root);

my $fout;

sub file_opened_hook
{
	my $foutname = &FileName();
	$foutname =~ s/\.[^\/]*$/\.1i.tbl/;
	open $fout, ">:encoding(iso-8859-2)", $foutname or die "Cannot open the file $foutname\n";
}

sub file_close_hook
{
	close $fout if $fout;
}

sub main 
{
	for (my $a_node = $root->following; $a_node; $a_node = $a_node->following)
	{
		my @a_parents = &eparents($a_node);
		my $a_par_id = $a_parents[0]->{'id'};
		printf $fout "%s --- - --- -\n",
			&feature_string($a_node, $a_parents[0]);
	}
}

