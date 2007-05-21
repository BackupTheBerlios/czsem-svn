#!/usr/bin/perl
# Convert trees from Negra export format to FS format, for browsing in
# TrEd.
# The original representation is not converted. (Constituency trees are not
# converted to dependency trees.)
#
# Original code by Zdenek Zabokrtsky, clean up by Ondrej Bojar
# {zabokrtsky,bojar}@ckl.ms.mff.cuni.cz

use Fslib;
  # Fslib is a part of TrEd distribution
use strict;

use Getopt::Std;
getopts('d:m:n:hu');
our ($opt_h, $opt_u, $opt_m, $opt_n, $opt_d);

if (@ARGV < 1 or $opt_h or $opt_u) {
  print <<EOF;
Usage: $ARGV[0] [-d output-directory ] [ flags ] file1 [ file2 ... ]
Convert files from Negra export format to FS format.
EOF
  if ($opt_h) {
    print <<EOF;
Options:
  -d directory  The output directory where to save converted files.
  -m outfile    Merge all input files and write to outfile
  -n number     Use in combination with -m, limits the maximum number of trees
                in the output file. The output filename should contain '\%d'
                or similar sprintf identifier to hold the file number.
  -h / -u       Help or usage.
EOF
  }
  exit 1;
}

my $outdir = $opt_d ? $opt_d."/" : "";



# -------------- auxiliary routines for reading Negra trees -----------

sub children {
  my ($NG_subtree_root,$NG_tree_ref) = @_;
  return
    grep {$$NG_tree_ref{$_}{parent} eq $NG_subtree_root}
      (keys %$NG_tree_ref);
}

sub arraymax {
  my $max=0;
  map {if ($max<$_) {$max=$_}} @_;
  return $max;
}

sub add_rightmost_child_index {
  my ($NG_subtree_root,$NG_tree_ref)=@_;  
  my @children = children($NG_subtree_root,$NG_tree_ref);
  if (@children==()) {
    $$NG_tree_ref{$NG_subtree_root}{"right_most_child"}
      = $NG_subtree_root
  } else {
    $$NG_tree_ref{$NG_subtree_root}{"right_most_child"}
      = arraymax(
          map {add_rightmost_child_index($_,$NG_tree_ref)}
            children($NG_subtree_root,$NG_tree_ref)
        );
  }
  return $$NG_tree_ref{$NG_subtree_root}{"right_most_child"};
}



# -------------- build tree structure -----------

sub create_fs_tree {
  # recursively build the tree structure
  my ($tg_tree_ref, $tg_parent, $fs, $fs_parent)=@_;
  my ($fs_node,$tg_node);
  foreach $tg_node
      (grep {$$tg_tree_ref{$_}{"parent"} eq $tg_parent} keys %$tg_tree_ref) {
    $fs_node=FSNode->new();    # new fs node
    $fs_node->{ord}=$tg_node;
    foreach ("form", "tag","morph","edge","ord","parent") {
      $fs_node->{$_}=$$tg_tree_ref{$tg_node}{$_}
    };
    if ($$tg_tree_ref{$tg_node}{form}!~/^#5/) {
      $fs_node->{visform}=$$tg_tree_ref{$tg_node}{form}
    };
    Paste($fs_node,$fs_parent,$fs->FS->defs());
    create_fs_tree($tg_tree_ref, $tg_node, $fs, $fs_node);
  }
}

sub store_tree_ref_into_fs {
  my ($fs, $trees_in_fs, $tg_tree_ref)=@_;

  my $root=$fs->new_tree($trees_in_fs); # creates the new root
  $root->{form}="#$trees_in_fs";
  $root->{ord}=$$tg_tree_ref{0}{ord}; # horizontal position of the root

  create_fs_tree($tg_tree_ref, 0, $fs, $root); # create recursively the fs nodes
}

sub compute_ord($$) {
  my ($tree,$node)=@_;
  if ($node<500 && $node>0) {$$tree{$node}{ord}=$node}
  else {
    my @sons=(grep {$$tree{$_}{parent}==$node && $node ne $_} keys %$tree);
    my $sum=0;
    foreach my $son (@sons) {
      compute_ord($tree,$son);
      $sum+=$$tree{$son}{ord};
    }
    $$tree{$node}{ord}=($sum/($#sons+1)+0.1);
  }
}


# -------------- create and save fs files -----------


sub create_blank_fsfile_for_NegraTree {
  my @fs_attributes = ( # specification of tree attributes for fs-format
    '@V visform', '@P form', '@P form', '@P tag', '@P morph',
    '@P edge', '@N ord', '@P parent');
  my $fs=  FSFile->create(                 # create a blank fs-file structure
                     FS => FSFormat->create(@fs_attributes),
                     hint => '${tag}',  # context hint when mouse over the node
                     patterns => ['${form}','${edge}','${tag}','${morph}'],
                                        # what to display
                     trees => [],       # there are no trees yet
                     backend => 'FSBackend');   # the output format is FS
  return $fs;
}

sub save_fsfile {
  my $fs = shift;
  my $fname = shift;
  print STDERR "Saving $fname\n";
  $fs->changePatterns('rootstyle:#{Line-coords:n,n,n,p&n,p,p,p}',
                      '${form}','${edge}','${tag}','${morph}');
  $fs->writeFile($fname);
}


# -------------- main -----------


my $fs = undef;
my $sentnum = 0;
my $fileno = 0;

foreach my $inf (@ARGV) {
  open INF, "$inf" or die "Can't read '$inf'";

  while (! eof(INF)) {
    my %NT_tree;
    my $node_id=0;
    # skip until the beginning of a sentence
    while (<INF>) {
      last if m/^\#BOS (.+)/;
    }
    # read the nodes of the sentence
    while (<INF>) {
      my $line=$_;
      last if (m/^\#EOS/);
      if (m/^#(\d+)/) {
        $node_id=$1
      } else {
        $node_id++
      }
      map { $line=~s/(\S+)//; $NT_tree{$node_id}{$_}=$1}
          ("form","tag","morph","edge","parent");
    }
    add_rightmost_child_index(0,\%NT_tree);

    # A sentence was loaded, convert it

    if (!defined $fs) {
      $fs = create_blank_fsfile_for_NegraTree();
    }

    $sentnum ++;
    compute_ord(\%NT_tree, 0);
    store_tree_ref_into_fs($fs, $sentnum, \%NT_tree);

    if ($opt_m && $opt_n && $sentnum >= $opt_n) {
      $fileno ++;
      $sentnum = 0;
      my $outfname = $outdir.sprintf($opt_m, $fileno);
      save_fsfile($fs, $outfname);
      $fs = undef;
    }
  }
  close INF;

  if (!$opt_m) {
    # need to save the current file
    my $outfname = $outdir.$inf.".fs";
    save_fsfile($fs, $outfname);
    $fs = undef;
  }
}
if ($opt_m && defined $fs) {
  # Save the remaining sentences
  $fileno ++;
  $sentnum = 0;
  my $outfname = $outdir.sprintf($opt_m, $fileno);
  save_fsfile($fs, $outfname);
  $fs = undef;
}
print STDERR "Done.\n";
