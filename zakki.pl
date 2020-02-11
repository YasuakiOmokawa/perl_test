#! /usr/bin/env perl

use strict;
use warnings;
use utf8;
use Encode qw/encode decode/;

my @files = qw(f1.md f2.f2-1.md f3.f3-1.f3-2.log.bak f4.f4-1.f4-2.log.bak.bak2);
for my $file (@files) {
  print "-----------\n";
  print "before => $file\n";
  $file =~ s/(.+)\.[^.]+$/$1\.html/;
  print "after  => $file\n";
}
