#!btred -TNe root_verb_flow()


use vars qw($this $root);

#my @verbs = ("vyjest", "zasahovat", "likvidovat", "zlikvidovat");
my @verbs = ("zranit");

################################################################################
sub root_verb_flow()
{
	if ($this->{gram}{sempos} eq "v")
	{
		foreach my $v (@verbs)
		{		
			if ($this->{t_lemma} eq $v )
			{
				print "\n";
				print $this->{t_lemma};
				print " -------------";
				foreach my $ch ($this->children()) {print " (" . $ch->{functor} . "),";}
				print "--------------";
				print "\n" . PML_T::GetSentenceString($root);
				
	#			print_ANodes();
	#			my @acts = find_functor_node($this, "ACT");
				my @acts = $this->children();
							
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
#sub add_anodes_to_list #($t_node, $a_list)
#{
#	my ($t_node, $a_list) = @_;
#
#	foreach my $a (PML_T::GetANodes($t_node))
#	{
#		push(@$a_list, $a);
# 	}	
#}

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
sub find_functor_node($parent, $functor)
{
	my($parent, $functor) = @_;
	
	my @ret = ();
	

	foreach my $child ($parent->children())
	{
		if ($child-{functor} =~ /^$functor/)
		{
			push(@ret, $child);
#			print $child->{functor} . " - ";
#			print $child->{t_lemma} . ",    ";
		}
	}
	
	return @ret;
}


################################################################################
sub print_ANodes()
{
			 foreach my $anode (PML_T::GetANodes($this))
			 {
        			print $anode->attr('m/tag');
				print " ";
				print $anode->attr('m/form');
				print ", ";
			}
}
