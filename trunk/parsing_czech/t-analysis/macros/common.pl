
use strict;
use warnings;

#======================================================================

sub tag_2ch
{
	my ($tag) = @_;
	$tag ne "" or return '##';
	return substr($tag, 4, 1) eq '-'? substr($tag, 0, 2) :
		substr($tag, 0, 1).substr($tag, 4, 1);
}

#======================================================================

sub tag
{
	my ($tag) = @_;
	my $ret = "";
	$tag ne "" or $tag = '#' x 15;
	my @t = split //, $tag;
	for (0, 1, 2, 3, 4, 7, 8, 9, 10, 11)
	{
		$ret .= $t[$_] . " ";
	}
	return $ret;
}
	
#======================================================================

sub adjust_lemma
{
	my ($lemma) = @_;
	$lemma =~ s/(.+?)[-_`].*$/$1/;
	$lemma ne "" or $lemma = "######";
	return $lemma;
}

#======================================================================

sub aid
{
	my ($node) = @_;
	$node or die "Assertion failed";
	my $ret = $node->attr($node eq $node->root? 'atree.rf' : 'a/lex.rf');
	return defined $ret? $ret : "";
}

#======================================================================

# Determines which nodes are members of a coordination mainly on the basis of their functors. 
# Recursive procedure. Returns effective functor of the input node.
# Nested coordinations are handled correctly. The procedure tries to be as robust as possible.

no warnings "recursion";

sub add_is_member
{
	my ($node) = @_;
	my %ch_func = (); # {functor} -> (children of $node having the functor)
	my $max; # functor with maximal number of children

	for my $ch ($node->children) {
		my $func = &add_is_member($ch);
		push @{$ch_func{$func}}, $ch;
	}

	unless (&PML_T::IsCoord($node)) { # unless coord node ...
		map { $_->{'is_member'} = undef } $node->children; # ... it has no members
		return $node->{'functor'};
	}

	# only for coordinations from now
	for (keys %ch_func) {
		if (@{$ch_func{$_}} >= 2) {
#			!defined $max or print STDERR "# $node->{'id'}: conflicting functors ($max vs. $_)\n"; 
			$max = $_;
		}
	}

	unless (defined $max) { # no functor with at least 2 nodes
		if ($node->children) {
			if (scalar(grep { $_->{'is_member'} } $node->children)) { # some children are members => retain everything
#				print STDERR "^ $node->{'id'}: children unchanged\n";
				map { return $_->{'functor'} } grep { $_->{'is_member'} } $node->children; # any child being a member
			}
			else { # none of the children is member => they all become members
#				print STDERR "@ $node->{'id'}: all children forced to be members\n";
				map { $_->{'is_member'} = 1 } $node->children;
				return $node->firstson->{'functor'};
			}
		}
		else { # no children => nothing to solve
#			print STDERR "\$ $node->{'id'}: coord without members\n";
			return $node->{'functor'};
		}
	}

	map { $_->{'is_member'} = undef } $node->children;
	map { $_->{'is_member'} = 1 } @{$ch_func{$max}};
	return $max;
}

use warnings "recursion";

#======================================================================

1;
