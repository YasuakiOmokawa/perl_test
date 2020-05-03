#! /usr/bin/env perl
use strict;
use warnings;
use Encode qw(decode encode);
use utf8;
use JSON;
use Data::Dumper;
use feature qw(say);

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

# データ一覧表示
my $json = JSON->new->utf8->canonical->pretty->encode(\@datas);
say $json;

# データを使って計算
my $sato_sales = 0;
for my $data (@datas) {
  $sato_sales += $data->{sales} if $data->{member} eq '佐藤';
}
say encode('UTF-8', "佐藤さんの売り上げは ${sato_sales} 円です。");
