#!btred -T -e main()

use strict;
use warnings;
require "$ENV{'A2T'}/2/macros/comm2.pl";

use vars qw($this $root);

my $fout;

sub file_opened_hook
{
	my $foutname = &FileName();
	$foutname =~ s/\.[^\/]*$/\.2i.tbl/;
	open $fout, ">:encoding(iso-8859-2)", $foutname or die "Cannot open the file $foutname\n";
}

sub file_close_hook
{
	close $fout if $fout;
}


sub main
{
	for (my $t_node = $root->following; $t_node; $t_node = $t_node->following)
	{
		printf $fout "%s - -\n",
			&feature_string($t_node);
	}
}

