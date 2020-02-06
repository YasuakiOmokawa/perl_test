#! /usr/bin/env perl

use strict;
use warnings;
use utf8;
use Encode qw/encode decode/;

my @iphones = qw(iPhone6 iPhone6s iPhone7 iPhone7s);
for my $iphone (@iphones) {
  if ($iphone =~ /iPhone6s?/) {
    print "it is target iPhone => $iphone\n";
  }
}
