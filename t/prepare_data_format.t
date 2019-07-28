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
use JSON;

# add search path to our modules
my $MY_DIR  = "";
BEGIN {
  $MY_DIR = dirname(__FILE__);
};
use lib "$MY_DIR/../lib";

# test module
# use JSON;
use TsvToJson qw(tsv_to_json);

# static settings
my $top_dir = dirname(__FILE__) . "/..";
my $prog_name = basename(__FILE__);
my $prog_base = $prog_name;
$prog_base =~ s/^(.*)\..*$/$1/;
my $test_data_dir = "$top_dir/t/data/$prog_base";
my $savefile = "$test_data_dir/test.json";
my $itemfile_imo = "$test_data_dir/imo_item.json";

my $checkers;
subtest "prepare item json" => sub {

  my $file     = "$test_data_dir/imo_src_of_data_format.tsv";
  my $savefile = "$test_data_dir/imo_src_of_data_format.json";

  open my $fh, "<", $file
    or die "Can't open $file: $!";

  my $json_data = tsv_to_json($fh);
  open(my $out, ">", $savefile);
  print $out $json_data;
  close $out;
  $checkers = create_checker_item();
  is(TRUE, 1, 'ok');
  done_testing;
};

subtest "imodcs upper limit" => sub {
  my $id = 'upper_limit';
  my $res    = $checkers->{imo_dcs}{"data_$id"};
  my $expect = $checkers->{imo_dcs}{"expect_$id"};

  for my $key (keys(%{$expect})) {
    is($expect->{$key}, $res->{$key}, "$key");
  }
  done_testing;
};

sub create_checker_item {
  my $file     = "$test_data_dir/imo_src_of_data_format.json";

  open my $fh, "<", $file
    or die "Can't open $file: $!";

  my $content = do { local $/; <$fh> };
  close $fh;
  my $src = decode_json($content);
  my $src_imo = $src->{'{data}{for_annual}{imo_dcs}'};

  my $chks = {
    imo_dcs => {
      data_upper_limit => {},
      expect_upper_limit => {},
    }
  };
  for my $row (@{$src_imo}) {

    if ($row->{has_limit}) {

      $chks->{imo_dcs}->{data_upper_limit}->{$row->{item}}   = $row->{data_upper_limit};
      $chks->{imo_dcs}->{expect_upper_limit}->{$row->{item}} = $row->{expect_upper_limit};
    }
  }
  return $chks;
}

done_testing;
