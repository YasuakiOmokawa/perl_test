use strict;
use warnings;
use Capture::Tiny qw/ capture /;
use Test::More;
use Test::Exception;
use Data::Dumper;
use constant {
  TRUE  => 1,
  FALSE => 0,
};

# add search path to our modules
use FindBin;
use lib "$FindBin::Bin/../../lib";

# test module
use SPVM 'PracticalCode::Gear';

# begin test
subtest "new" => sub {
  my $gear = new PracticalCode::Gear(52, 11, 1, 1.0);
  isa_ok($gear, 'PracticalCode::Gear');

  done_testing;
};

subtest "get field data" => sub {
  my $gear = new PracticalCode::Gear(52, 11, 1, 1.0);
  is($gear->chainring, 52, 'chainring');
  is($gear->cog, 11, 'cog');

  done_testing;
};

subtest "ratio" => sub {
  my $gear = new PracticalCode::Gear(30, 27, 1, 1.0);
  is($gear->ratio, 1.11111116409302, 'valid');

  done_testing;
};

subtest "gear_inches" => sub {
  my $gear = new PracticalCode::Gear(52, 11, 26, 1.5);
  is($gear->gear_inches, 137.090896606445, 'valid');

  done_testing;
};



done_testing;
