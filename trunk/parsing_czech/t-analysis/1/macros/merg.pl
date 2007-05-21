#!btred -T -e main()

use strict;
use warnings;
require "$ENV{'A2T'}/1/macros/comm1.pl";

use vars qw($this $root);

STDOUT->autoflush(1);
STDERR->autoflush(1);

my $ftbl;

sub file_opened_hook
{
	my $ftblname = &FileName();
	$ftblname =~ s/\.[^\/]*$/\.1o.tbl/;
	open $ftbl, "<:encoding(iso-8859-2)", $ftblname or die "Cannot open the file $ftblname\n";
	&ChangingFile(1);
}

sub file_close_hook
{
	close $ftbl if $ftbl;
}

sub main 
{
#	print ">> ", PML_T::GetSentenceString($root)."\n";

	my %succs = (); # { id of a deleted t-node } -> its successor (or undef, if deleted and s. not known)
	my %a2t = (); # { a-id } -> t-node (because of &eparent)
	
	for (my $t_node = $root; $t_node; $t_node = $t_node->following)
	{
		$a2t{ substr(&aid($t_node), 2) } = $t_node;
	}

	# mark transformations
	for (my $t_node = $root->following; $t_node; $t_node = $t_node->following)
	{
		my $a_node = &PML_T::GetANodeByID($t_node->attr('a/lex.rf'));
		my $pml_lemma = &adjust_lemma($a_node->attr('m/lemma'));

		my $line;
		defined ($line = <$ftbl>) or die "Unexpected end of file";
		$line =~ s/(.*)\| ([0-9]+ )*$/$1/; # strip rule' numbers
		$line =~ /^(\S+) .* (\S+) (\S+) \S+ \S+ $/ or die "Bad line in the input file: \"$line\"";
		my ($lemma, $ftor, $del_par) = ($1, $2, $3);
		$lemma eq $pml_lemma or die "The input files do not match ($lemma vs. $pml_lemma)";
	
		# get the e-parent of the node in question (have to be the same as in the TBL file, so using &eparents)
		my $a_epar = (&eparents($a_node))[0]; # a-node being the effective parent
		$a_epar or die "Assertion failed";
		my $t_epar = $a2t{ $a_epar->{'id'} }; # t-node being the effective parent
		$t_epar or die "Assertion failed";
		
		# register transformations
		if ($del_par eq 'D' && $t_epar ne $root) # the root cannot be deleted -- ignore the rule
		{
			my $t_echild = $t_node; # successor of a node is always its child (ergo special handling of coordinations); alas when coord node is not annotated right, it does not hold true
			while ($t_echild->{'is_member'} && &PML_T::IsCoord($t_echild->parent)) { $t_echild = $t_echild->parent }
			$succs{ $t_epar->{'id'} } = $t_echild unless $t_epar eq $t_echild; # condition for weird coords
		}
		if ($ftor eq 'xxx') { $succs{ $t_node->{'id'} } = undef unless exists $succs{ $t_node->{'id'} } }
		else { $t_node->{'functor'} = $ftor if $t_node->{'functor'} ne '---' }
	}

	# delete leaves to be deleted
	my $done;
	do {
		$done = 1;
		for my $t_node_id (keys %succs)
		{
			my $t_node = &PML::GetNodeByID($t_node_id); # the t-node to be deleted
			$t_node or die "Assertion failed, $t_node_id";
			next if $t_node->firstson; # only leaves
			$done = 0;
			print $t_node_id, ", ", $t_node->{'t_lemma'}, "\n";
			my $a_node = &PML_T::GetANodeByID($t_node->attr('a/lex.rf')); # the a-node to be deleted
			$a_node or die "Assertion failed, $t_node_id";

			# move the deleted node and "its" previously deleted nodes into a/aux.rf of the their successor
			&PML_A::ANodeToAAuxRf($a_node, $t_node->parent, $grp->{'FSFile'}) unless $a_node->{'afun'} =~ /^Aux[GKX]$/;
			map { &PML_A::ANodeToAAuxRf( &PML_T::GetANodeByID($_), $t_node->parent, $grp->{'FSFile'}) } &ListV($t_node->attr('a/aux.rf'));

			# delete it
			map { $succs{$_} = undef } grep { defined $succs{$_} && $succs{$_} eq $t_node } keys %succs; # in successors, delete the deleted node (another successor will be assigned later)
			&PML_T::DeleteNode($t_node);
			delete $succs{ $t_node_id };
		}
	} until $done;

	# if no successor, fill in one
	for my $t_node_id (grep { !defined $succs{$_} } keys %succs)
	{
		my $t_node = &PML::GetNodeByID($t_node_id); # a node to be deleted
		$t_node or die "Assertion failed, $t_node_id";
		$t_node->children or die "Assertion failed, $t_node_id";
		print $t_node_id, ", ", $t_node->{'t_lemma'}, ": ";
		if ($t_node->children == 1) # clear case
		{
			print "implicit successor assigned\n";
			$succs{$t_node_id} = $t_node->firstson;
		}
		else # more candidates -- give it up
		{
			print "has ", scalar($t_node->children), " children, will be retained\n";
			delete $succs{$t_node_id};
			$t_node->{'functor'} = 'RSTR' if $t_node->{'functor'} eq 'xxx';
		}
	}

	
	# delete inner nodes to be deleted
	while (my @nodes = keys %succs)
	{
		# select the "lowest" node
		my $t_node_id = $nodes[0];
		while (defined $succs { $t_node_id } && exists $succs{ $succs { $t_node_id }->{'id'} }) 
		{ 
			$t_node_id = $succs{ $t_node_id }->{'id'};
		}
			
		# get the real nodes
		my $t_node = &PML::GetNodeByID($t_node_id); # a node to be deleted
		$t_node or die "Assertion failed, $t_node_id";
		my $a_node = &PML_T::GetANodeByID($t_node->attr('a/lex.rf')); # a-node for $t_node
		defined $succs{$t_node_id} or die "Assertion failed";
		my $succ = $succs{$t_node_id}; # successor of the node being deleted; t-node

		# rehang the successor and the children
		print $t_node_id, ", ", $t_node->{'t_lemma'}, ": onto ", $succ->{'t_lemma'};
		&PasteNode(&CutNode($succ), $t_node->parent); # rehang the successor
		map { &PasteNode(&CutNode($_), $succ) } grep { $_->{'id'} ne $succ->{'id'} } $t_node->children; # rehang the children
		map { $succs{$_} = $succ } grep { defined $succs{$_} && $succs{$_} eq $t_node } keys %succs; # in %succs, change the deleted node into its successor

		# move the deleted node and "its" previously deleted nodes into a/aux.rf of the their successor
		for my $exp_succ (&PML_T::ExpandCoord($succ))
		{
			&PML_A::ANodeToAAuxRf($a_node, $exp_succ, $grp->{'FSFile'});
			map { &PML_A::ANodeToAAuxRf( &PML_T::GetANodeByID($_), $exp_succ, $grp->{'FSFile'}) } &ListV($t_node->attr('a/aux.rf')); 
		}
		
		# finally, delete the node
		&PML_T::DeleteNode($t_node);
		delete $succs{ $t_node_id };

		print "\n";
	}

}

# Naslednik uzlu je uzel, ktery prejde na jeho misto -- bude mit stejneho otce a prebere (zbyvajici) deti. Je jim nektere z deti.
# Nejprve jsou zruseny listy, aby se tam nemotaly pri rozhodovani o implicitnim naslednikovi. Pokud to neni Aux[GKX], zapise se do a/aux.rf rodice.
# Uzly jsou rusene pocinaje ve strome nejhlubsimi. Pokud se totiz vyskytne retizek uzlu, ktere maji byt zrusene, jiny pristup by vedl k tomu, ze po prvni transformaci by se vyskytnul uzel, jehoz naslednikem bude jeho predek, a ten by tak musel byt povesen na sveho potomka, coz je blbe. Dalsi vyhodou je, ze se od zacatku zapisuje do a/aux.rf spravneho uzlu.
# Zapisuje se do a/aux.rf naslednika, ale pokud je to koordinace, zapisuje se do koordinovanych clenu.
# Pokud neni naslednik urcen pravidlem a ma (po zruseni listu) vice nez jedno dite, od ruseni se upousti, nebot neni jasne, ktery uzel by mel byt naslednik.
# Pocita se s tim, ze uz je to temer dobre anotovane, takze se vyuziva IsCoord apod.
