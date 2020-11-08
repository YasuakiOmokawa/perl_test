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
  my $gear = new PracticalCode::Gear(52, 11);
  isa_ok($gear, 'PracticalCode::Gear');

  done_testing;
};

subtest "get data" => sub {
  my $gear = new PracticalCode::Gear(52, 11);
  is($gear->get_chainring, 52, 'chainring');
  is($gear->get_cog, 11, 'cog');

  done_testing;
};



done_testing;
