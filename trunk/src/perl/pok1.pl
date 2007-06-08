#!btred -TNe main()

use vars qw($this $root);

#my @verbs = ("vyjest", "zasahovat", "likvidovat", "zlikvidovat");
my @verbs = ("odstranit");
my @injure_verbs = ("zranit", "usmrtit", "zemřít");
my @key_words = ("strom", "xhodina", "xnehoda");
my @functors = ("^.*HEN");

################################################################################
sub main
{
	print_injured();
	#root_verb_flow();
	#key_word_search();
	#functor_search();
}


################################################################################
sub functor_search
{
	foreach my $functor (@functors)
	{		
		if ($this->{functor} =~ /$functor/)		
#		if ($this->{functor} eq $functor )
		{
			print "\n". $this->{functor} ."---------------". $this->{t_lemma} ."----------------";
			#print $this->{t_lemma};
			print "\n" . PML_T::GetSentenceString($root)."\n";
			
#			print_sub_functors($this);
			
			
			print_subtree ($this);
			print_subtree_as_text($this);
#			print "\n";
			
		}
	}	
}

################################################################################
sub key_word_search
{
	foreach my $key (@key_words)
	{		
		if ($this->{t_lemma} eq $key )
		{
			print "\n---------------". $this->{t_lemma} ."----------------";
			#print $this->{t_lemma};
			print "\n" . PML_T::GetSentenceString($root)."\n";
			
			print_sub_functors($this);
			
			
#			print_subtree ($this);
#			print_subtree_as_text($this);
#			print "\n";
			
		}
	}
	
}

################################################################################
sub print_injured
{
	if ($this->{gram}{sempos} eq "v")
	{
		foreach my $v (@injure_verbs)
		{		
			if ($this->{t_lemma} eq $v )
			{
				print "\n";
				print $this->{t_lemma};
				print ": -------- a(";
				print_ANodes($this);
				print ") ---------";
#				foreach my $ch ($this->children()) {print " (" . $ch->{functor} . "),";}
#				print "--------------";
				print "\n" . PML_T::GetSentenceString($root);
				
				my @acts = find_node_by_attr($this, 'functor', "PAT");
							
				foreach my $act (@acts)
				{
					print "\nnext:   ";
					print_subtree ($act);
					print_subtree_as_text($act);	
				}
	
				print "\n" 
			}
		}
	}
	
} 

################################################################################
sub root_verb_flow()
{
	if ($this->{gram}{sempos} eq "v")
	{
		foreach my $v (@verbs)
		{
			#print "$v\n";		
			if ($this->{t_lemma} eq $v )
			{
				print "\n";
				print $this->{t_lemma};
				print ": -------- a(";
				print_ANodes($this);
				print ") ---------";
				foreach my $ch ($this->children()) {print " (" . $ch->{functor} . "),";}
				print "--------------";
				print "\n" . PML_T::GetSentenceString($root);
				
	#			print_ANodes();
	#			my @acts = find_functor_node($this, "ACT");
#				my @acts = $this->children();

				print_sub_functors($this);
							
	
				print "\n" 
			}
		}
	}
}

sub print_sub_functors($t_node)
{
	my ($t_node) = @_;
						
	foreach my $act ($t_node->children())
	{
		print "\nnext:   ";
		print_subtree ($act);
		print_subtree_as_text($act);
	}	
}

################################################################################
sub print_subtree_as_text($node)
{
	print "\n        ";
	
	my($node) = @_;
	my @anode_list = ();
	my @stack = ($node);
		
	while (defined($top = pop(@stack)))
	{
		foreach my $a (PML_T::GetANodes($top))
		{
			push(@anode_list, $a);
 		}	

		foreach my $ch ($top->children())
		{
			push (@stack, $ch);
		}
		
	}
	
	
	my @s_alist = sort {$a->attr('ord') <=> $b->attr('ord')} @anode_list;	
	

	foreach my $a (@s_alist)
	{
		print $a->attr('m/form') . " ";
	}
	

}

################################################################################
sub print_subtree($node)
{
	my($node) = @_;
	
	print $node->{functor} . "(";
	
	foreach my $a (PML_T::GetANodes($node))
	{
		# hledat pad http://ufal.mff.cuni.cz/pdt2.0/doc/manuals/cz/a-layer/html/
		print $a->{afun}. " ";
	}
	
	
	print "): " . $node->{t_lemma} . ",   ";

	
	foreach my $ch ($node->children())
	{
		print_subtree($ch);
	}	
}


################################################################################
sub find_node($parent, $test_sub)
{
	my($parent, $test_sub) = @_;	
	my @ret = ();
	
	shift();
	shift();

	foreach my $child ($parent->children())
	{
		if (&$test_sub($child, @_))
		{
			push(@ret, $child);
		}
	}

	return @ret;
}

################################################################################
sub test_attr($node, $attr, $value)
{
	my($node, $attr, $value) = @_;
	($node->attr($attr) =~ /$value/)	
}


################################################################################
sub find_node_by_attr($parent, $attr, $value)
{
	my($parent, $attr, $value) = @_;		
	return &find_node($parent, \&test_attr, $attr, $value);	
}



################################################################################
sub get_negation_from_Anode($anode)
{
	my ($anode) = @_;
	
	return substr ($anode->attr('m/tag'), 10, 1);		
}

################################################################################
sub print_ANodes($t_node)
{
	my($t_node) = @_;

	foreach my $anode (PML_T::GetANodes($t_node))
	{
		#print $anode->attr('m/tag');
		print $anode->attr('m/form');
		print "." . &get_negation_from_Anode($anode);
		print ", ";
	}
}

