package TsvToJson;

use strict;
use warnings;
use File::Basename;
use Carp qw(croak);
use constant {
  TRUE  => 1,
  FALSE => 0,
};
use JSON;
use Exporter qw(import);
our @EXPORT_OK = qw(tsv_to_json);

my $MY_DIR  = "";
BEGIN {
  $MY_DIR = dirname(__FILE__);
};
use lib "$MY_DIR/../lib";

sub tsv_to_json {
  my $fh = shift;
  my @headers;
  my $json_data = {};
  my $is_header = TRUE;
  while (<$fh>) {

    # 改行コードはデータ処理に不便なことが多いため、削除
    chomp;

    my @row = split /\t/, $_;

    # ヘッダ情報は後で使うので保存
    if ($is_header) {
      $is_header = FALSE;
      @headers = @row;
      next;
    }

    # データの列名をkeyにし、項目をvalueにしたハッシュ（行ハッシュ）を作る
    my %hash;
    @hash{@headers} = @row;

    # 集計項目
    my $key = 'data';

    # 集計配列の初期作成
    $json_data->{$key} = [] unless exists $json_data->{$key};

    # 集計配列へ、作成した行ハッシュを追加
    push @{$json_data->{$key}}, \%hash;
  }

  # JSONデータへ変換
  return to_json($json_data, {utf8=>1, pretty=>1, canonical=>1});
}

1;

__END__

my $key = $hash{year};
