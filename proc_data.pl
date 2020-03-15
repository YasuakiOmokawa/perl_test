#! /usr/bin/env perl
use strict;
use warnings;

while (my $line = <>) {
  chomp $line;
  my @row = split /,/, $line;

  print "$row[0]\n";
}
