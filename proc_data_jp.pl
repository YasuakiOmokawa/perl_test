#! /usr/bin/env perl
use strict;
use warnings;
use Encode qw(decode encode);
use utf8;
use feature qw(say);

my $is_header = 1;
my @headers;
my @datas;
my $sales_sato = 0;

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

  # データを使って計算
  $sales_sato += $hash{sales} if $hash{member} =~ /佐藤/;
}

say encode('UTF-8', "佐藤さんの売り上げは ${sales_sato} 円です。");

__END__
use JSON;
use Data::Dumper;
# データ一覧表示
my $json = JSON->new->utf8->canonical->pretty->encode(\@datas);
say $json;
  # 結果配列に格納
  push @datas, \%hash;
