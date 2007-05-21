#!btred -T -e main()

use strict;
use warnings;
require "$ENV{'A2T'}/3/macros/comm3.pl";

use vars qw($this $root);
use vars qw(@func);

my $ftbl;

#======================================================================

sub create_tnode
{
	my ($t_par, $func) = @_;
	my $t_node = &PML_T::NewNode($t_par);
	$t_node->{'functor'} = $func;
	$t_node->{'t_lemma'} = '#Gen';
	$t_node->{'is_generated'} = 1;
	$t_node->{'nodetype'} = 'complex'; 
	# temporarily assign (dirty) deepord -- place it to the left of the subtree of its parent
	my $min = $t_par->{'deepord'};
	for ($t_par->descendants) {
		$_->{'deepord'} >= $min or $min = $_->{'deepord'};
	}
	$t_node->{'deepord'} = $min - 0.1;
	return $t_node;
}

#======================================================================

sub file_opened_hook
{
	my $ftblname = &FileName();
	$ftblname =~ s/\.[^\/]*$/\.3o.tbl/;
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
	my %ftor_cnt = ();
	
	# mark transformations
	for (my $t_node = $root->following; $t_node; $t_node = $t_node->following) {
		next if $t_node->{'is_generated'} || &PML_T::IsCoord($t_node); # generated parents and coordinations are ignored

		# read and check data
		my $line;
		defined ($line = <$ftbl>) or die "Unexpected end of file";
		$line =~ s/(.*)\| ([0-9]+ )*$/$1/; # strip rule' numbers
		$line =~ /^(\S+) (\S+ ){6}(\S+) (\S+) ((\S+ ){27})\S+ \S+ (\S+ ){27}\s+$/ or die "Bad line in the input file: \"$line\"";
		$1 eq $t_node->{'t_lemma'} or die "The input files do not match ($1 vs. $t_node->{'t_lemma'})";

		# register new nodes and perform change of functor
		@{$ftor_cnt{$t_node->{'id'}}} = map { substr($_, 0, -1) } split / +/, $5;
		my $func = $4;
		if ($t_node->{'functor'} ne $func) { print "$t_node->{'id'}: $t_node->{'functor'} => $func\n"; }
		$t_node->{'functor'} = $func;
		my @t_pars = &PML_T::GetEParents($t_node);
		@t_pars && $t_pars[0] or @t_pars = ($t_node->parent);
		$t_pars[0]->{'val_frame.rf'} = $3 if $3 ne '---';
	}

	for (my $t_node = $root->following; $t_node; $t_node = $t_node->following) {
		next if $t_node->{'is_generated'} || &PML_T::IsCoord($t_node); # generated parents and coordinations are ignored

		# fill %nodes
		my %nodes = (); # { functor } => t_node's real children with this functor
		for my $ch (&real_children($t_node)) {
			push @{$nodes{ $ch->{'eff_func'} } }, $ch;
			undef $ch->{'eff_func'};
		}

		# add new nodes
		my $i=0;
		for my $final_cnt (@{$ftor_cnt{$t_node->{'id'}}}) {
			$nodes{ $func[$i] } or @{$nodes{ $func[$i] }} = (); # to have it defined
			if (@{$nodes{ $func[$i] }} > $final_cnt) {
				print "$t_node->{'id'}: ", @{$nodes{ $func[$i] }}-$final_cnt, " superfluous node(s) with $func[$i]\n";
			}
			while (@{$nodes{ $func[$i] }} < $final_cnt) { # less nodes with the given functor than should be
				my $new_node = &create_tnode($t_node, $func[$i]);
				print "new node on $t_node->{'id'} with $func[$i]\n";
				push @{$nodes{ $func[$i] }}, $new_node;
			}
			$i++;
		}
	
	}


	# make common modifications from generated modifications of members of a coordination
	for (my $t_node = $root->following; $t_node; $t_node = $t_node->following)
	{
		&PML_T::IsCoord($t_node) or next;
		my %common; # { functor }{ parent } => generated children with this functor having this parent, which is a coordinated node
		my @coorded = &PML_T::ExpandCoord($t_node); # coordinated nodes
		for my $par (@coorded) {
			for my $ch (&real_children($par)) {
				$common{ $ch->{'functor'} }{ $par->{'id'} } = $ch if $ch->{'is_generated'} && $ch->children == 0;
			}
		}
		for my $func (grep { keys %{$common{$_}} == @coorded } keys %common) {
			for my $ch_node (values %{$common{$func}}) {
				&DeleteLeafNode($ch_node);
			}
			my $new_node = &create_tnode($t_node, $func);
		}
			
	}

	# normalize deepords
	my @nodes = ();
	for (my $t_node = $root; $t_node; $t_node = $t_node->following) { push @nodes, $t_node }
	&SortByOrd(\@nodes);
	&NormalizeOrds(\@nodes);
	
}

