#!btred -e main()

# 1. nodes with a/lex.rf
#    a. 1:1 -> pair them (majority of original nodes solved)
#    b. 1:more or more:1 or more:more -> try to pair them by children (copies of original nodes solved)
# 2. nodes without a/lex.rf and rest of the previous (i.e. 0:anything and vice versa)
#    a. -> try to pair by children (inner added nodes--like empty predicates--solved)
#    b. -> try to pair by parent and functor (added leave nodes solved)
#    c. -> try to pair by parent OR functor

use strict;
use warnings;

use vars qw($this $root);

my ($cnt1, $cnt2) = (0, 0);
my ($match, $m1a, $m1b, $m2a, $m2b, $m2c) = (0) x 6;
my (%p1, %p2); # {id of t-node} -> its pair-t-node

my @attr = qw( struct functor val_frame.rf t_lemma nodetype gram/sempos a/lex.rf a/aux.rf is_member is_generated deepord subfunctor tfa );
my %match = ();

######################################################################

sub make_pair
{
	my ($n1, $n2, $where) = @_;
	$n1 && $n2 or die "Assertion failed";
	no warnings 'uninitialized';
#	print STDERR "$where: $n1->{'id'} $n2->{'id'} ($n1->{'t_lemma'} $n2->{'t_lemma'})\n";
	use warnings 'uninitialized';
	!exists $p1{ $n1->{'id'} } or die "Assertion failed ($n1->{'id'})";
	!exists $p2{ $n2->{'id'} } or die "Assertion failed ($n2->{'id'})";
	$p1{ $n1->{'id'} } = $n2;
	$p2{ $n2->{'id'} } = $n1;
	$match++;
	for ($where) {
		/1a/ and $m1a++;
		/1b/ and $m1b++;
		/2a/ and $m2a++;
		/2b/ and $m2b++;
		/2c/ and $m2c++;
	}
}

######################################################################

sub pair_by_children
{
	my ($list1, $list2, $force) = @_;
	
	my %scores = (); # { id of t-node1 }{ id of t-node2 }->how much "equal" children they have 
#	print STDERR scalar(@$list1), " ", scalar(@$list2), "\n";
	# get statistics
	for my $node1 (@$list1) {
		for my $ch1 (grep { $p1{ $_->{'id'} } } $node1->children) { # traverse only paired children
			my $ch2 = $p1{ $ch1->{'id'} };
			$scores{ $node1->{'id'} }{ $ch2->parent->{'id'} }++;
		}
	}
	# find maximal score and store the best nodes into $max1 and $max2
	while (@$list1 && @$list2) {
		my $max1 = $list1->[0];
		my $max2 = $list2->[0];
		no warnings 'uninitialized';
		for my $node1 (@$list1) {
			for my $node2 (@$list2) {
				if ($scores{ $node1->{'id'} }{ $node2->{'id'} } > $scores{ $max1->{'id'} }{ $max2->{'id'} }) {
					($max1, $max2) = ($node1, $node2);
				}
			}
		}
		$force || $scores{ $max1->{'id'} }{ $max2->{'id'} } > 0 or return; # no nodes can be paired
		&make_pair($max1, $max2, ($force? "1b" : "2a"));
		for my $node1 (@$list1) { $scores{ $node1 }{ $max2 } = 0 } # zero scores of the best nodes...
		for my $node2 (@$list2) { $scores{ $max1 }{ $node2 } = 0 }
		@$list1 = grep { $_ ne $max1 } @$list1; # ... and delete them from the lists
		@$list2 = grep { $_ ne $max2 } @$list2;
#		print STDERR scalar(@$list1), " ", scalar(@$list2), "\n";
	}
}

######################################################################

sub debug_par_son
{
	my ($p) = @_;
	for my $par_id (keys %$p) {
		print STDERR  $par_id, "\n";
		for my $func (keys %{$p->{$par_id}}) {
			print STDERR "  ", $func, ": ", ( join ", ", map { $_->{'id'} } @{ $p->{$par_id}{$func} } ), "\n";
		}
	}
}

######################################################################

sub nodes_match 
{
	my ($n1, $n2, $attr) = @_;
	no warnings 'uninitialized';
	return $n1->attr($attr) eq $n2->attr($attr);
	use warnings 'uninitialized';
}

######################################################################

sub count_res
{
	my ($name, $m, $c2, $c1) = @_;
	return sprintf "%-13s %5d  P=%4.1f%%, R=%4.1f%%, F=%4.1f%%\n",
		$name, $m, 100 * $m/$c2, 100 * $m/$c1, 100 * 2*$m/($c1+$c2);
}

######################################################################

&register_exit_hook( sub 
{ 
	#---------------------------------------------------------------------
	# print statistics

	no integer;
	printf "\n%d, %d (%d=%d+%d+%d+%d+%d)\n", $cnt1, $cnt2, $match, $m1a, $m1b, $m2a, $m2b, $m2c;
	for (@attr) {
		print &count_res($_, $match{$_}, $cnt2, $cnt1);
	}
} );

######################################################################

sub main 
{
	#---------------------------------------------------------------------
	# initialization and gathering information

	&LastFileNo() % 2 == 1 or die "Usage: [ correct_t-file test_t-file ]*\n";

	for (my $i = 0; $i <= $grp->{'FSFile'}->lastTreeNo; $i++) {
		&GotoTree($i+1) == $i or die "Assertion failed\n";

		%p1 = ();  %p2 = ();

		my %a_to_t1 = ();
		my %a_to_t2 = ();

		my @unpaired1 = ();
		my @unpaired2 = ();

		for (my $n1 = $root->firstson; $n1; $n1 = $n1->following) {
			$cnt1++;
			if ($n1->attr('a/lex.rf')) { push @{ $a_to_t1{ $n1->attr('a/lex.rf') } }, $n1 }
			else { push @unpaired1, $n1 }
		}
		
		&NextFile;
		if (&GotoTree($i+1) != $i) { 
			print "The files contain different number of trees\n";
			next;
		}

		for (my $n2 = $root->firstson; $n2; $n2 = $n2->following) {
			$cnt2++;
			if ($n2->attr('a/lex.rf')) { push @{ $a_to_t2{ $n2->attr('a/lex.rf') } }, $n2 }
			else { push @unpaired2, $n2 }
		}
		
	#---------------------------------------------------------------------
	# pairing
	
		# 1a. nodes with a/lex.rf, 1:1

		for (keys %a_to_t1) {
			if (@{ $a_to_t1{$_} } == 1 && $a_to_t2{$_} && @{ $a_to_t2{$_} } == 1) {
				my $node1 = $a_to_t1{$_}->[0];
				my $node2 = $a_to_t2{$_}->[0];
				&make_pair($node1, $node2, "1a");
				delete $a_to_t1{$_};
				delete $a_to_t2{$_};
			}
		}
			
		# 1b. nodes with a/lex.rf, 1:more or more:1 or more:more

		for (keys %a_to_t1) {
			if ($a_to_t2{$_} && @{ $a_to_t2{$_} }) { 
				&pair_by_children($a_to_t1{$_}, $a_to_t2{$_}, 1);
			}
		}
	
		# declare nodes remaining in $a_to_t[12] to be unpaired
		for (keys %a_to_t1) { push @unpaired1, @{ $a_to_t1{$_} } }
		for (keys %a_to_t2) { push @unpaired2, @{ $a_to_t2{$_} } }

		undef %a_to_t1; undef %a_to_t2;
		@unpaired1 && @unpaired2 or goto COUNT;

		# 2a. try to pair by children
		&pair_by_children(\@unpaired1, \@unpaired2, 0);
		@unpaired1 && @unpaired2 or goto COUNT;
		
		# convert remaining nodes
		my %par_son1 = (); # { id of node's parent }{ node's functor }->(nodes in question)
		my %par_son2 = ();
		for (@unpaired1) {
			push @{ $par_son1{ $_->parent->{'id'} }{ $_->{'functor'} } }, $_;
		}
		for (@unpaired2) {
			defined $_->parent->{'id'} or die;
			defined $_->{'functor'} or die $_->{'id'};
			push @{ $par_son2{ $_->parent->{'id'} }{ $_->{'functor'} } }, $_;
		}
		undef @unpaired1; undef @unpaired2;

		# 2b.

		for my $par1_id (keys %par_son1) { # id of a parent
			my $par2 = $p1{ $par1_id };
			my $par2_id = $par2->{'id'}; # without $par2, $p1{ $par1_id } would spring into existence!
			$par2_id && $par_son2{ $par2_id } or next; # id of corresponding parent
			for my $func (keys %{$par_son1{ $par1_id }}) {
				$par_son2{ $par2_id }{ $func } && @{ $par_son2{ $par2_id }{ $func } } or next;
				my ($node1, $node2);
				while ($node1 = shift @{ $par_son1{ $par1_id }{ $func } }, 
					$node2 = shift @{ $par_son2{ $par2_id }{ $func } }, $node1 && $node2) {
					&make_pair($node1, $node2, "2b");
				}
				!defined $node1 or unshift @{ $par_son1{ $par1_id }{ $func } }, $node1;
				!defined $node2 or unshift @{ $par_son2{ $par2_id }{ $func } }, $node2;
				if (@{ $par_son1{ $par1_id }{ $func } } == 0) { delete $par_son1{ $par1_id }{ $func } }
				if (@{ $par_son2{ $par2_id }{ $func } } == 0) { delete $par_son2{ $par2_id }{ $func } }
			}
			
		}

		# 2c.

		# for parents of remaining nodes count number of their sons into %par_count[12]
		my %par_count1 = ();
		my %par_count2 = ();
		for my $par1_id (keys %par_son1) {
			for my $func (keys %{$par_son1{ $par1_id }}) {
				$par_count1{ $par1_id } += @{ $par_son1{ $par1_id }{ $func } };
			}
		}
		for my $par2_id (keys %par_son2) {
			for my $func (keys %{$par_son2{ $par2_id }}) {
				$par_count2{ $par2_id } += @{ $par_son2{ $par2_id }{ $func } };
			}
		}

		my %will_be_paired = ();
		# decrease numbers noted with pairs of parents so that prevent their children from unwanted pairing
		# since interested in paired, no need to do for %par_son2 too
		for my $par1_id (grep { $p1{ $_ } } keys %par_son1) {
			my $par2 = $p1{ $par1_id };
			my $par2_id = $par2->{'id'};
			$par2_id or die "Assertion failed ($par1_id)";
			no warnings 'uninitialized';
			if ($par_count1{ $par1_id } > $par_count2{ $par2_id }) {
				$will_be_paired{ $par1_id } += $par_count1{ $par2_id };
				$par_count1{ $par1_id } -= $par_count2{ $par2_id };
				$par_count2{ $par2_id } = 0;
			}
			else {
				$will_be_paired{ $par1_id } += $par_count1{ $par1_id };
				$par_count2{ $par2_id } -= $par_count1{ $par1_id };
				$par_count1{ $par1_id } = 0;
			}
		}

		# search for pairs matching in functors
		# for ($par1_id, $func) search for $par2_id such that ($par2_id, $func) exists
		RESTART: for my $par1_id (grep { $par_count1{ $_ } > 0 } keys %par_son1) {
			for my $func (keys %{$par_son1{ $par1_id }}) {
				@{ $par_son1{ $par1_id }{ $func } } or die "Assertion failed ($par1_id, $func)";
				for my $par2_id (grep { $par_count2{ $_ } > 0 } keys %par_son2) {
					my $list2 = $par_son2{ $par2_id }{ $func };
					defined $list2 && @$list2 or next;
					&make_pair(shift @{ $par_son1{ $par1_id }{ $func } }, shift @$list2, "2c");
					$par_count2{ $par2_id }--;
					$par_count1{ $par1_id }--;
					if (@{ $par_son1{ $par1_id }{ $func } } == 0) { delete $par_son1{ $par1_id }{ $func } }
					if (@{ $par_son2{ $par2_id }{ $func } } == 0) { delete $par_son2{ $par2_id }{ $func } }
					goto RESTART; # the safest solution
				}
			}
		}
		
		# pair the noted nodes (matching in their parent)
		for my $par1_id (keys %will_be_paired) {
			while ($will_be_paired{ $par1_id } > 0) {
				my $par2 = $p1{ $par1_id };
				my $par2_id = $par2->{'id'};
				$par2_id or die "Assertion failed ($par1_id)";
				@_ = keys %{ $par_son1{ $par1_id } }; my $func1 = $_[0]; $func1 or die;
				@_ = keys %{ $par_son2{ $par2_id } }; my $func2 = $_[0]; $func2 or die;
				&make_pair(shift @{ $par_son1{ $par1_id }{ $func1 } }, shift @{ $par_son2{ $par2_id }{ $func2 } }, "2c");
				$will_be_paired{ $par1_id }--;
				if (@{ $par_son1{ $par1_id }{ $func1 } } == 0) { delete $par_son1{ $par1_id }{ $func1 } }
				if (@{ $par_son2{ $par2_id }{ $func2 } } == 0) { delete $par_son2{ $par2_id }{ $func2 } }
			}
		}
			

	#---------------------------------------------------------------------
	# counting

		my $prevnode2 = undef; # for counting of deepord
		
		COUNT: for my $node1 (sort {$a->{'deepord'} <=> $b->{'deepord'}} map { $p2{$_} } keys %p2) {
			$node1 or die;
			my $node2 = $p1{$node1->{'id'}};
			$node1 eq $p2{$node2->{'id'}} or die;
			$node2->parent->{'id'} or die;
			$node1->parent->{'id'} or die;
			
			for (@attr) {
				if ($_ eq 'struct') { # structure
					$match{$_}++ if ($node1->parent eq $node1->root && $node2->parent eq $node2->root) 
						|| ($p2{ $node2->parent->{'id'} } && $p2{ $node2->parent->{'id'} } eq $node1->parent); 
				}
				elsif ($_ eq 'deepord') {
					# we know that previous $node1->{'deepord'} < current $node1->{'deepord'}
					$match{$_}++ if (!$prevnode2 && $node2->{'deepord'} == 1) || ($prevnode2 && $prevnode2->{'deepord'}+1 == $node2->{'deepord'});
				}
				elsif ($_ eq 'a/aux.rf') {
					$match{$_}++ if (join " ", sort &ListV($node1->attr($_))) 
						eq (join " ", sort &ListV($node2->attr($_)));
				}
				else { # other attributes
					$match{$_}++ if &nodes_match($node1, $node2, $_);
				}
			}
			$prevnode2 = $node2;
		}

#		for my $p (keys %par_son2) {
#			for my $f (keys %{$par_son2{$p}}) {
#				for (@{ $par_son2{$p}{$f} }) { print STDERR "$_->{'id'} ($_->{'t_lemma'})\n" }
#			}
#		}

		&PrevFile;
	}

	&NextFile;
}

