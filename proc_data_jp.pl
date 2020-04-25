#! /usr/bin/env perl
use strict;
use warnings;
use Encode qw(decode encode);
use utf8;
use Data::Dumper;

my $sales = 0;
my $is_header = 1;
my @headers;
my @datas;

while ( my $line = <> ) {
  chomp $line;
  my @row = split /,/, decode('Shift_JIS', $line);

  if ($is_header) {
    $is_header = 0;
    @headers = @row;
    next;
  }

  # { データの列名 => 項目 } とする
  my %hash;
  @hash{@headers} = @row;

  # 結果配列に格納
  push @datas, \%hash;
}

print Dumper \@datas;
