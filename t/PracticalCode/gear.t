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
use SPVM 'SPVM::Hash';

# add search path to our modules
use FindBin;
use lib "$FindBin::Bin/../../lib";

# test module
use SPVM 'PracticalCode::Wheel';
use SPVM 'PracticalCode::Gear';

# begin test
my $args_wheel = SPVM::Hash->new;
$args_wheel->set_int(rim => 26);
$args_wheel->set_float(tire => 1.5);

my $args_gear = SPVM::Hash->new;
$args_gear->set_int(chainring => 52);
$args_gear->set_int(cog => 11);
$args_gear->set(wheel => new PracticalCode::Wheel($args_wheel));

subtest "new" => sub {
  my $gear = new PracticalCode::Gear($args_gear);
  isa_ok($gear, 'PracticalCode::Gear');
  done_testing;
};

subtest "ratio" => sub {
  my $gear = new PracticalCode::Gear($args_gear);
  is($gear->ratio, 4.72727251052856);
  done_testing;
};

subtest "gear_inches" => sub {
  my $gear = new PracticalCode::Gear($args_gear);
  is($gear->gear_inches, 137.090896606445);
  done_testing;
};

done_testing;