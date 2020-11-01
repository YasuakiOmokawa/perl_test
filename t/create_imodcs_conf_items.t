use strict;
use warnings;

use Capture::Tiny qw/ capture /;
use Test::More;
use Test::Exception;
use Data::Dumper;
use Benchmark;
use File::Basename;
use POSIX qw(strftime);
use constant {
  TRUE  => 1,
  FALSE => 0,
};
use utf8;
use open IO => qw/:encoding(UTF-8)/;

# add search path to our modules
my $MY_DIR  = "";
BEGIN {
  $MY_DIR = dirname(__FILE__);
};
use lib "$MY_DIR/../lib";

# test module
use JSON;

# static settings
my $top_dir = dirname(__FILE__) . "/..";
my $prog_name = basename(__FILE__);
my $prog_base = $prog_name;
$prog_base =~ s/^(.*)\..*$/$1/;
my $test_data_dir = "$top_dir/t/data/$prog_base";
my $file = "$test_data_dir/test.tsv";
my $savefile = "$test_data_dir/test.json";
my $itemfile_imo = "$test_data_dir/imo_item.json";

subtest "create def items json" => sub {

  is(TRUE, 1, 'ok');

  open my $fh, "<", $file
    or die "Can't open $file: $!";

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
    $json_data->{$hash{key}} = {} unless exists $json_data->{$hash{key}};
    my %d = %hash;
    $json_data->{$hash{key}}->{$hash{item}} = \%d;
  }
  # print Dumper $json_data;
  open(my $out, ">", $savefile);
  print $out to_json($json_data, {utf8=>1, pretty=>1});
  close $out;

  done_testing;
};

subtest "create def config file" => sub {

  is(TRUE, 1, 'ok');

  open my $fh, "<", $savefile
    or die "Can't open $file: $!";

  my $content = do { local $/; <$fh> };
  close $fh;
  my $src = decode_json($content);
  my $src_imo = $src->{'{data}{for_annual}{imo_dcs}'};
  # print Dumper $src_imo->{voyage_number};

  # json content
  my $json_imo = {
    for_annual => {
      imo_dcs => []
    }
  };

  # add json item
  for my $key (keys(%{$src_imo})) {

    my $item = {};
    $item->{$key}              = {};
    $item->{$key}->{type}      = "none";
    $item->{$key}->{format}    = {};
    $item->{$key}->{threshold} = {};

    if ( !($src_imo->{$key}{'{threshold}{min}'} eq 'null' || $src_imo->{$key}{'{threshold}{max}'} eq 'null') ) {

      $item->{$key}->{threshold} = {
        min => $src_imo->{$key}{'{threshold}{min}'},
        max => $src_imo->{$key}{'{threshold}{max}'}
      };
    } else {
      delete $item->{$key}->{threshold};
    }

    for my $inner_key (qw/round datetime init_val/) {

      my $mix_key = "{format}{$inner_key}";
      # is($src_imo->{$key}{$mix_key}, '""', "escape char match");
      $item->{$key}->{format}->{$inner_key} = $src_imo->{$key}{$mix_key} eq '""' ? "" : $src_imo->{$key}{$mix_key}
    }

    push @{$json_imo->{for_annual}{imo_dcs}}, $item;
  }

  open(my $out, ">", $itemfile_imo);
  print $out to_json($json_imo, {utf8=>1, pretty=>1});
  close $out;

  done_testing;
};

done_testing;
