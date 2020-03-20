#! /usr/bin/env perl
use strict;
use warnings;

my $sales = 0;
while (my $line = <>) {
  chomp $line;
  my @row = split /,/, $line;

  $sales += $row[2];
  print "$row[0], $row[2]\n";
  print "$row[0], $sales\n";
}
