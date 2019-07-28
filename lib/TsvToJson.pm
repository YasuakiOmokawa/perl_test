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
  my $is_header = TRUE;
  my @headers;
  my %hash;
  my $json_data = {};
  while (<$fh>) {
    chomp;
    my @row = split /\t/, $_;
    if ($is_header) {
      $is_header = FALSE;
      @headers = @row;
      next;
    }

    @hash{@headers} = @row; # @ヘッダ名と項目のkey - valueデータを作る
    $json_data->{$hash{key}} = [] unless exists $json_data->{$hash{key}};
    my %d = %hash;
    push @{$json_data->{$hash{key}}}, \%d;
  }

  return to_json($json_data, {utf8=>1, pretty=>1});
}

1;