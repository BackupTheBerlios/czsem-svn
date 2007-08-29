#!btred -TNe main()

use vars qw($this $root);

#my @verbs = ("vyjest", "zasahovat", "likvidovat", "zlikvidovat");
my @verbs = ("odstranit");
my @injure_verbs = ("zranit", "usmrtit", "zemřít", "zahynout", "přežít"); #podlehnout, utrpět zranění, těžce zraněný, s těžkým zraněním
my @key_words = ("těžký", "strom", "hodina", "nehoda");
my @functors = ("^.*HEN");
my @persons = ("kdo", "člověk", "osoba", "muž", "žena", "dítě", "řidička", "řidič", "spolujezdec", "spolujezdkyně");
my @numbers = ("jeden", "dva", "tři", "čtyři", "pět", "šest", "sedm", "osm", "devět", "deset", "jedenáct",
 "dvanáct", "třináct", "čtrnáct", "patnáct", "šestnáct", "sedmnáct", "osmnáct", "devatenáct", "dvacet");

################################################################################
sub main
{	
	print_injured();
	#root_verb_flow();
	#key_word_search();
	#functor_search();
}

################################################################################
sub test_attr($node, $attr, $value)
{
	my($node, $attr, $value) = @_;
	($node->attr($attr) =~ /$value/)	
}

################################################################################
sub filter_list_by_attr(@list, $attr_name, $attr_value)
{
	my (@list) = @_;
	shift();
	
	return filter_list(@list, \&test_attr, @_)			
}

################################################################################
sub test_number($str)
{
	my $str = $_[0];
	
	for (my $i = 0; $i <= $#numbers; $i++)
	{
		if ($str eq @numbers[$i])
		{ 
			return $i + 1;
		} 
    }
    
    if ($str =~ /^[0-9]*$/)
    {
    	return $str;
    }
    
    return ();
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
			
#			print_sub_functors($this);
			
			
			print_subtree ($this);
			print_subtree_as_text($this);
			print "\n";
			
		}
	}
	
}

################################################################################
sub filter_list($test_sub, @list)
{
	my ($test_sub, @list) = @_;
	shift(); shift(); 
	
	my @ret = ();
	
	foreach my $i (@list)
	{
		if (&$test_sub($i, @_))
		{
			push (@ret, $i);			
		}
	}
	
	return @ret;		
}

################################################################################
sub test_person($person_node)
{
	my $person_node = $_[0];
	
	foreach my $p (@persons)
	{
		if ($p eq $person_node->{t_lemma})
		{
			return 1;
		}		
	}
	return 0;	
}

sub test_number_lemma($t_node)
{
	my $t_node = $_[0];
	
	return &test_number($t_node->{t_lemma});	
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
				#action type
				print "<action type=\"" . $this->{t_lemma} . "\">";

				#sentece
				print "<sentece>" . PML_T::GetSentenceString($root) . "</sentece>";
				print "<sentece_id>" . $root->{id} . "</sentece_id>";
				

				#negation
				if (test_negation($this))
				{
					print "<negation>true</negation>" ;					
				}
				else
				{
					print "<negation>false</negation>" ;										
				}
				


				
				#manner of injurance
				my @mans = find_node_by_attr_depth($this, 0, 'functor', '^MANN');
				if (@mans)
				{
					foreach my $m (@mans)
					{
						print "<manner>"; 
						print $m->{t_lemma};
						print "</manner>"; 
					};
				}
				
				#actors and patients
				my @pats = find_node_by_attr($this, 'functor', '^[PA][AC]T');
				@pats = &filter_list(\&test_person, @pats);
				
				foreach my $p (@pats)
				{
					print "<participant type=\">" . $p->{t_lemma} . "\">";

					#patients count
					my @cnt = find_node_by_attr($p, 'functor', '^RSTR');
					@cnt = &filter_list(\&test_number_lemma, @cnt);
					my $cnt1 = pop(@cnt);
					print "<quantity>" . &test_number($cnt1->{t_lemma}) . "</quantity>" if ($cnt1);
	
					print "<full_string>";
					print_subtree_as_text($p);
					print "</full_string>";

					print "</participant>";
				}
				
				#action end
				print "</action>\n";
											
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

################################################################################
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
	#print "\n        ";
	
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
#Otestuje A-uzly odpovidajici T-uzlu $t_node 
sub find_A_node($t_node, $test_sub)
{
	my($t_node, $test_sub) = @_;	
	my @ret = ();

	shift();
	shift();

	foreach my $anode (PML_T::GetANodes($t_node))
	{
		if (&$test_sub($anode, @_))
		{
			push(@ret, $ch);
		}
	}
	
	return @ret;	
}


################################################################################
#Rekurentne hleda v T-podstromu $parent uzlu, pouze do hlobky zadane v promenne $depth 
sub find_node_depth($parent, $depth, $test_sub)
{
	my($parent, $depth, $test_sub) = @_;
	
	
	shift();
	shift();
	shift();

	my @ret = ();
	my @stack = ($depth, $parent);
	
	while (defined(my $top = pop(@stack)))
	{
		my $d = pop(@stack);
		foreach my $ch ($top->children())
		{
			if (&$test_sub($ch, @_))
			{
				push(@ret, $ch);
			}
			
			if ($d > 0)
			{
				 push (@stack, $d-1);
				 push (@stack, $ch);
			}
		}
		
	}
	
	return @ret;	
}

################################################################################
#Rekurentne hleda v T-podstromu uzlu $parent
sub find_node($parent, $test_sub)
{
	my($parent, $test_sub) = @_;
	shift();
	shift();
	return &find_node_depth($parent, 1000, $test_sub, @_);
}


################################################################################
sub find_node_by_attr_depth($parent, $depth ,$attr, $value)
{
	my($parent, $depth, $attr, $value) = @_;			
	return &find_node_depth($parent, $depth , \&test_attr, $attr, $value);	
}

################################################################################
sub find_node_by_attr($parent, $attr, $value)
{
	my($parent, $attr, $value) = @_;		
	return &find_node($parent, \&test_attr, $attr, $value);	
}



################################################################################
sub test_negation($t_node)
{
	my ($t_node) = @_;
	
	#pro T-uzel by melo fungovat, buhuzel nas anlyzator to nevyplnuje
	#print $t_anode->attr('gram/negation');
	
	foreach my $a (PML_T::GetANodes($t_node))
	{
		return 1 if get_negation_from_Anode($a) eq "N";		
	}
	
	return 0;
}

################################################################################
sub get_negation_from_Anode($anode)
{
	my ($anode) = @_;
	
	#pro T-uzel by melo fungovat, buhuzel nas anlyzator to nevyplnuje
	#print $this->attr('gram/negation');
	
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


