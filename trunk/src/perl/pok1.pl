#!btred -TNe root_verb_flow()


use vars qw($this $root);

my $verb = "likvidovat";



sub root_verb_flow()
{
	
	if ($this->{gram}{sempos} eq "v")
	{
		if ($this->{t_lemma}  eq $verb)
		{
			print "\n";
			print $this->{t_lemma};
			print " -------------";
			foreach my $ch ($this->children()) {print " (" . $ch->{functor} . "),";}
			print "--------------";
			
#			print_ANodes();
#			my @acts = find_functor_node($this, "ACT");
			my @acts = $this->children();
						
			foreach my $act (@acts)
			{
				print "\nnext:   ";
				print_subtree ($act);

			}

			print "\n" 
		}
	}
}

sub pokus2 (xxx, yyy)
{
	
}

sub print_subtree($node)
{
	my($node) = @_;
	
	print $node->{functor} . ": " . $node->{t_lemma} . ",   ";

	
	foreach my $ch ($node->children())
	{
		print_subtree($ch);
	}	
}

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
