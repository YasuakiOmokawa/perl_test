#! /usr/bin/env perl
use strict;
use warnings;

my $sales = 0;
my $is_header = 1;
while (my $line = <>) {
  chomp $line;
  my @row = split /,/, $line;

  if ($is_header) {
    print "$row[0], $row[2]\n";
    $is_header = 0;
    next;
  }

  $sales += $row[2];
  print "$row[0], $sales\n";
}
