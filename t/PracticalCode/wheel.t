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
use SPVM 'PracticalCode::Wheel';

# begin test
subtest "new" => sub {
  my $wheel = new PracticalCode::Wheel(26, 1.5);
  isa_ok($wheel, 'PracticalCode::Wheel');

  done_testing;
};

subtest "circumference" => sub {
  my $wheel = new PracticalCode::Wheel(26, 1.5);
  is($wheel->circumference, 91.106186954104, 'valid');

  done_testing;
};

done_testing;
