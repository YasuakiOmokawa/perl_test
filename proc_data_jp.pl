#! /usr/bin/env perl
use strict;
use warnings;

use Encode qw(decode encode);
use utf8;

my $sales = 0;
my $is_header = 1;
my @headers;
while ( my $line = decode('Shift_JIS', <>) ) {
  print $line . "\n";
  chomp $line;
  my @row = split /,/, $line;

  if ($is_header) {
    $is_header = 0;
    @headers = @row;
    next;
  }

  # { データの列名 => 項目 } とする
  my %hash;
  @hash{@headers} = @row;

  use Data::Dumper;
  print Dumper \%hash;

  print $hash{member} . "\n";
  # print encode('UTF-8', $hash{member}) . "\n";
}
