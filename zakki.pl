#! /usr/bin/env perl

use strict;
use warnings;
use utf8;
use Encode qw/encode decode/;

my %h = qw(A な B ん D り C つ E い );

print encode('UTF-8', "$h{A}$h{B}$h{C}$h{A}$h{D}$h{E}") . "\n";

# use Data::Dumper;
# print Dumper \%a;