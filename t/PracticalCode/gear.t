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
use SPVM 'PracticalCode::Wheel';

# begin test
subtest "new" => sub {
  my $wheel = new PracticalCode::Wheel(26, 1.5);
  my $args = {chainring => 52, cog => 11, wheel => $wheel};
  my $gear = new PracticalCode::Gear($args);
  isa_ok($gear, 'PracticalCode::Gear');

  done_testing;
};

subtest "ratio" => sub {
  my $wheel = new PracticalCode::Wheel(1, 1.0);
  my $gear = new PracticalCode::Gear(30, 27, $wheel);
  ok($gear->ratio, 1.11111116409302);

  done_testing;
};

subtest "gear_inches" => sub {
  my $wheel = new PracticalCode::Wheel(26, 1.5);
  my $gear = new PracticalCode::Gear(52, 11, $wheel);
  ok($gear->gear_inches, 137.090896606445);

  done_testing;
};



done_testing;
