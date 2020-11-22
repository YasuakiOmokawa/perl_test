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
use SPVM 'PracticalCode::Mechanic';

# begin test
subtest "new" => sub {
  my $mechanic = new PracticalCode::Mechanic;
  isa_ok($mechanic, 'PracticalCode::Mechanic');
  done_testing;
};

subtest "prepare_bicycles" => sub {
  my $mechanic = new PracticalCode::Mechanic($args);
  is($mechanic->prepare_bicycles, "something");
  done_testing;
};

done_testing;
