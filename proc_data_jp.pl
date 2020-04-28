#! /usr/bin/env perl
use strict;
use warnings;
use Encode qw(decode encode);
use utf8;
use JSON qw(encode_json);
use Data::Dumper;
use feature qw(say);

my $sales = 0;
my $is_header = 1;
my @headers;
my @datas;

# 行入力セパレータをCRLFへ
local $/ = "\x0D\x0A";

while ( my $line = decode('Shift_JIS', <>) ) {
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

  # 結果配列に格納
  push @datas, \%hash;
}

say encode_json(\@datas);

say $datas[0]{member};