#!btred -t PML_A2T -e main()

#include <contrib/pml/PML_A2T.mak>

use strict;
use warnings;

use vars qw($this $root $grp);

sub with_file (&$) 
{
	local $grp->{'FSFile'} = $_[1];
	&{$_[0]};
}

sub new_t_node 
{
	my ($parent, $t_file, $a_node) = @_;
	my $new = &PML_T::InitNode(FSNode->new(), $parent);
	$new->{'id'} = &PML_T::NewID($parent);
	$new->{'deepord'} = $a_node->{'ord'};
	$new->{'t_lemma'} = $a_node->attr('m/lemma');
	$new->{'t_lemma'} =~ s/(.+?)[-_`].*$/$1/;
	with_file { &PasteNode($new, $parent) } $t_file;
	return $new;
}

sub main 
{
	# prologue
  my $t_file = &CreateTFile();

	# for all trees
  do {{
    my $t_root = &AddNewTTree($t_file);
#		print $t_root->{'id'},"\n";
		
		# for nodes
		my $t_node = $t_root;
		my $a_node = $root;
		my $t_new;
		do {{
			if ($a_node->firstson) {
				$a_node = $a_node->firstson;
				$t_new = new_t_node($t_node, $t_file, $a_node);
				$t_node = $t_new;
			}
			elsif ($a_node->rbrother) {
				$a_node = $a_node->rbrother;
				$t_new = &new_t_node($t_node->parent, $t_file, $a_node);
				$t_node = $t_new;
			}
			else {
				while (!$a_node->rbrother && $a_node ne $root) {
					$a_node = $a_node->parent;
					$t_node = $t_node->parent;
				}
				if ($a_node->rbrother) {
					$a_node = $a_node->rbrother;
					$t_new = &new_t_node($t_node->parent, $t_file, $a_node);
					$t_node = $t_new;
				}
			}
			&PML_A::ANodeToALexRf($a_node, $t_node, $t_file);
			$t_node->{'nodetype'} = 'complex' unless $a_node eq $root; 
			$t_node->{'functor'} = $a_node->{'afun'} eq 'Coord'? 'CONJ' : ($a_node->{'afun'} eq 'Apos'? 'APPS' : 'RSTR');
			$t_node->{'deepord'} = $a_node->{'ord'};
			$t_node->{'is_member'} = $a_node->{'is_member'};
		}} while $a_node ne $root;

		if ($t_root->firstson && $t_root->firstson->children == 1) { # handling particles at beginnings of sentences
			my $part = $t_root->firstson;
			$part->{'functor'} = 'RSTR';
			$part->firstson->{'is_member'} = undef;
		}
		
	}} while &NextTree();

	# epilogue
	$t_file->writeFile();
}

__END__

