#!btred -T -e main()

use strict;
use warnings;
require "$ENV{'A2T'}/2/macros/comm2.pl";

use vars qw($this $root);

STDOUT->autoflush(1);
STDERR->autoflush(1);

my $ftbl; # a file with TBL output

#======================================================================

sub init_tnode
{
	my ($t_node, $t_par) = @_;
	$t_node->{'is_generated'} = 1;
	# temporarily assign (dirty) deepord -- place it to the right of the subtree of its parent
	my $max = $t_par->{'deepord'};
	for ($t_par->descendants) {
		$_->{'deepord'} <= $max or $max = $_->{'deepord'};
	}
	$t_node->{'deepord'} = $max + 0.1;
}

#======================================================================

sub file_opened_hook
{
	my $ftblname = &FileName();
	$ftblname =~ s/\.[^\/]*$/\.2o.tbl/;
	open $ftbl, "<:encoding(iso-8859-2)", $ftblname or die "Cannot open the file $ftblname";
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
	my @descs = () ; # list of (t-node, description of a transformation)-pairs

	NODE: for (my $node = $root->following; $node; $node = $node->following) {
		# read the input
		my $a_node = &PML_T::GetANodeByID($node->attr('a/lex.rf'));
		my $pml_lemma = &adjust_lemma($a_node->attr('m/lemma'));

		my $line; # an input line
		defined ($line = <$ftbl>) or die "Unexpected end of file";
		$line =~ /^(\S+) .* (\S+) \S+ \| ([0-9]+ )*$/ or die "Bad line in the input file: \"$line\""; # strip rule' numbers
		my ($lemma, $desc) = ($1, $2);
		$lemma eq $pml_lemma or die "The input files do not match ($lemma vs. $pml_lemma)";
		undef $pml_lemma; undef $lemma; undef $line;
		$desc ne '-' or next;

		# fill the appropriate data structures with input data
		my $t_node = $node; # new variable, since we need to move all over the tree
		$desc =~ /^([^+:;|]+)(\+([^:;|]*))?(:([^;|]*))?(;([^|]*))?(\|(.*))?/ or die "Error in description of a transformation";
		my ($trans, @char2desc, @new_functors, @cop_functors, @succs);
		$trans        = $1; # a transformation
		@char2desc    = split /\+/, $3 if defined $3; # [ char-'A' ] -> its description
		@new_functors = split /\+/, $5 if defined $5; # list of functors of new nodes
		@cop_functors = split /\+/, $7 if defined $7; # list of functors of copied nodes
		@succs        = split /\+/, $9 if defined $9; # list of chars of successors
		
		print $t_node->{'id'}, ' ', $trans, ' ', (join '+', @char2desc), ' :', (join '+', @new_functors), ' ;', (join '+', @cop_functors), ' |', (join '+', @succs), "\n";
		unshift @char2desc, (undef, undef); # so that the first record is for 'A'

		# match the transformation in the tree
		my @nodes_in_trans = (); # [ char-'A' ] -> the corresponding node
		my ($ls, $rs) = split /->/, $trans; 
		my @l_side = split //, $ls; # left side of transformation split into characters
		defined $ls && defined $rs or die "Error in description of $trans";
		shift @l_side eq 'A' && shift @l_side eq '(' && shift @l_side eq 'B' or die "Error in description of $trans";
		$nodes_in_trans[0] = $t_node->parent; # 'A'
		print "  A = ", $t_node->parent eq $root? "<root>" : $t_node->parent->{'t_lemma'}, "\n";
		$nodes_in_trans[1] = $t_node; # 'B'
		print "  B = ", $t_node->{'t_lemma'}, "\n";
		my $letter = 'C'; # which node should be processed now
		while (defined ($_ = shift @l_side)) {
			/[A-Z,()]/ or die "Error in description of $trans";
			/,/  and do { $t_node = $t_node->rbrother };
			/\)/ and do { $t_node = $t_node->parent };
			/\(/ and do { $t_node = $t_node->firstson };
			/[A-Z]/ and do {
				$_ eq $letter or die "Error in description of $trans";
				$t_node = $t_node->rbrother while $t_node && &PML_T::GetANodeByID(&aid($t_node))->{'afun'} ne $char2desc[ ord($letter)-ord('A') ];
				unless ($t_node) # no node with the given description found
				{
					print "Cannot apply the transformation ($_ = ", $char2desc[ ord($letter)-ord('A') ], ")\n";
					next NODE;
				}
				$nodes_in_trans[ ord($letter)-ord('A') ] = $t_node;
				print "  $letter = ", $t_node->{'t_lemma'}, "\n";
				$letter++;
			};
		}

		# only jot down transformations (for fear of changing the structure while reading)
		push @descs, [ $trans, \@nodes_in_trans, \@new_functors, \@cop_functors, \@succs ];
	} # a node

	for (@descs) {
		my ($trans, $nodes_in_trans, $new_functors, $cop_functors, $succs) = @$_; # similar sense as above
		print "# $trans\n";
		my @new_id = (); # list of new nodes (id cannot be assigned while creating since the whole tree has to be build before)

		# cut and rehang the nodes
		my ($ls, $rs) = split /->/, $trans; 
		my @r_side = split //, $rs; # right side of transformation split into characters
		if ($nodes_in_trans->[0] eq $root && $r_side[0] ne 'A') { # the root of the sentence must remain at its place
			print "Cannot apply the transformation (the root should move)\n";
			next;
		}
		my $t_node; # the last visited node; and its parent
		my $t_par = $nodes_in_trans->[0]->parent; # transformed subtree will hang on A's parent
		unless ($t_par) {
			print "Due to previous transformations, A has no parent\n";
			next;
		}
		while (grep {$t_par eq $_} (@$nodes_in_trans)) { # this can happen only when a previous transformation is applied to these nodes
			print "  ! subroot had to be moved ($t_par->{'id'})\n";
			$t_par = $t_par->parent;
		}
		for (@$nodes_in_trans) { &CutNode($_) } # now we can safely cut off nodes
		while (defined ($_ = shift @r_side)) {
			/[A-Za-z,()*]/ or die "Error in description of $trans";
			/,/  and do { };
			/\)/ and do { $t_node = $t_par; $t_par = $t_par->parent };
			/\(/ and do { $t_par = $t_node; $t_node = undef; };
			/[A-Za-z]/ and do {
				my $letter = $_;
				my $is_copy = $letter =~ /[a-z]/; # the node is a copy of another node
				$letter = uc $letter;
				$t_node = $nodes_in_trans->[ ord($letter)-ord('A') ];

				if ($is_copy) { # if this is a copy, create new node and set its attributes
					my $orig = $t_node;
					$t_node = &PML_T::NewNode($t_par);
					for my $attr ($orig->type->get_member_names) { $t_node->{ $attr } = &PML_T::CloneValue($orig->{ $attr }) }
					&init_tnode($t_node, $t_par);
					push @new_id, $t_node;
					my $new_funct = shift @$cop_functors;
					$t_node->{'functor'} = $new_funct unless $new_funct eq '@';
				}
				else {
					&PasteNode($t_node, $t_par) if $t_par; # dirty trick -- unless $t_par, we are at 'A' and it has been root of the sentence => it actually has _not_ been cut off
				}
			};
			/\*/ and do {
				$t_node = &PML_T::NewNode($t_par);
				&init_tnode($t_node, $t_par);
				$t_node->{'nodetype'} = 'complex'; 
				push @new_id, $t_node;
				$t_node->{'functor'} = shift @$new_functors;
				$t_node->{'functor'} or die "Error in description of $trans"; # a functor is missing
			};
		}
		undef @r_side;

		# put ids of deleted nodes into successors' a/aux.rf and relocate children
		for my $node (@$nodes_in_trans) { 
			if (!$node->parent && $node ne $root) { # the node is deleted
				my $succ_char = shift @$succs; # description of its successor
				defined $succ_char or die "Error in description of $trans ($node->{'t_lemma'})";
				my $succ; # its successor
				$succ = $succ_char =~ /[A-Z]/? $nodes_in_trans->[ ord($succ_char)-ord('A') ] : $root->firstson; # back-off successor unless given
				map { &PML_A::ANodeToAAuxRf($_, $succ, $grp->{'FSFile'}) } &PML_T::GetANodes($node) unless $succ_char eq '0';
				map { &CutPaste($_, $succ) } $node->children if $node->children;
			}
		}
		
		for (@new_id) { $_->{'id'} = &PML_T::NewID($root) }

		# normalize deepords
		my @nodes = ();
		for ($t_node = $root; $t_node; $t_node = $t_node->following) { push @nodes, $t_node }
		&SortByOrd(\@nodes);
		&NormalizeOrds(\@nodes);
		
		
	} # a transformation

	&add_is_member($root);
}

