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
use SPVM 'PracticalCode::Trip';

# begin test
my $args = SPVM::Hash->new;
$args->set(bicycles => 1);
$args->set(customers => 1);
$args->set(vehicle => 1);

subtest "new" => sub {
  my $trip = new PracticalCode::Trip($args);
  isa_ok($trip, 'PracticalCode::Trip');
  done_testing;
};

subtest "prepare" => sub {
  my $trip = new PracticalCode::Trip($args);
  is($trip->prepare, "something");
  done_testing;
};

done_testing;
