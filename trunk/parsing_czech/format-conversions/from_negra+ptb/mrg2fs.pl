#!/usr/bin/perl
# Convert trees from Penn Treebank (mrg) format to FS format, for browsing in
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
Convert files from Penn Treebank format to FS format.
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


# -------------- ensure that the whole bracketed string is loaded -----------

sub balanced {
  # just checks whether the number of opening parentheses equals the number of
  # closing ones
  my $s = shift;
  my $op = $s;
  my $cl = $s;
  $op = $op =~ tr/(/(/;
  $cl = $cl =~ tr/)/)/;
  my $bal = ($op == $cl);
  return $bal;
}

# -------------- build tree structure -----------


sub insert_fs_tree ($$$$$) {
  # recursive adding of nodes to the last tree in the fs file structure
  # returns average ord of node children, in order to render the parent
  # (phrasal) node in between of the children's node
  my ($fs, $sentnum, $phrase_tree, $fs_parent,$node_number)=@_;
  my %phrase_tree = %{$phrase_tree};
  my $fs_node;
  $phrase_tree{$node_number}=~/^(\S*) (.+)/;
  my $phrase_type=$1;
  my $rest=$2;
  if (not $fs_parent) {
    $fs_node=$fs->new_tree($sentnum); # creates a new root
    $fs_node->{phrase_type}=$phrase_type;
    $fs_node->{ord}=0;
    $fs_node->{form}="#$sentnum";
  }
  else {
    # print STDERR "hang";
    $fs_node=FSNode->new();    # create a new node and hang it on its parent
    $fs_node->{phrase_type}=$phrase_type;
    $fs_node->{ord}=$node_number;
    Paste($fs_node,$fs_parent,$fs->FS->defs());
    # print STDERR " $fs_node->{ord} hung on $fs_parent->{ord}\n";
  }
  if ($rest=~/\&\d+/) {
    # a descendant found -> this is a non-terminal node
    my ($sum,$cnt);
    while ($rest=~s/&(\d+)//) { # create descendant fs subtrees
      $sum+=insert_fs_tree($fs, $sentnum, $phrase_tree, $fs_node,$1);
      $cnt++;
    }
    if ($cnt) {$fs_node->{ord}=sprintf "%.1f",($sum/$cnt)};
  }
  else {
    # a terminal node
    $fs_node->{ord}=$node_number;
    $rest=~s/^@//;
    $fs_node->{form}=$rest;
  }
  return  $fs_node->{ord};
}

sub convert_string_to_fs_tree {
  my $fs = shift;
  my $sentnum = shift;
  $_ = shift;

  my $node_number=1;
  my %phrase_tree=();
  while (s/\(([^\)\(]+)\)/\&$node_number/) {
    $phrase_tree{$node_number}=$1;
    $node_number++;
  }
  # print STDERR
  #  "Number of reductions performed on tree $sentnum: $node_number\n";
  $node_number=$node_number-1; #disregard the last reduction
  if ($node_number) {
    insert_fs_tree($fs, $sentnum, \%phrase_tree, 0, $node_number);
  }
}



# -------------- create and save fs files -----------


sub create_blank_fsfile_for_PTBTree {
  my @fs_attributes= ('@V form', '@P form', '@P phrase_type','@N ord');
  my $fs=  FSFile->create(                 # create a blank fs-file structure
                     FS => FSFormat->create(@fs_attributes),
                     hint => '${tag}',  # context hint when mouse over the node
                     patterns => ['${phrase_type}','${form}'],
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
                      '${phrase_type}','${form}' );
  $fs->writeFile($fname);
}




# -------------- main -----------


my $fs = undef;
my $sentnum = 0;
my $fileno = 0;

foreach my $inf (@ARGV) {
  open INF, "$inf" or die "Can't read '$inf'";

  my $sent = "";
  while (<INF>) {
    chomp;
    s/^[^\s]+:://g; # remove optional sentence number, if present
    # s/@//g; # strange hacks
    # s/\~//g; # strange hacks

    $sent .= $_;
    if ($sent !~ /^\s*$/ && balanced($sent)) {
      # if the whole sentence was loaded parse the tree structure
      if (!defined $fs) {
        $fs = create_blank_fsfile_for_PTBTree();
      }
  
      $sentnum ++;
      convert_string_to_fs_tree($fs, $sentnum, $sent);
      $sent = "";
  
      if ($opt_m && $opt_n && $sentnum >= $opt_n) {
        $fileno ++;
        $sentnum = 0;
        my $outfname = $outdir.sprintf($opt_m, $fileno);
        save_fsfile($fs, $outfname);
        $fs = undef;
      }
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



