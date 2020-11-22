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
use SPVM 'PracticalCode::WheelWrapper';

# begin test
my $args = SPVM::Hash->new;
$args->set_int(rim => 20);
$args->set_float(tire => 1.8);

subtest "new" => sub {
  isa_ok(PracticalCode::WheelWrapper->wheel($args), 'PracticalCode::Vendor::Wheel');
  done_testing;
};

subtest "circumference" => sub {
  my $wheel = PracticalCode::WheelWrapper->wheel($args);
  is($wheel->circumference, 74.1415878231416);
  done_testing;
};

subtest "hello" => sub {
  is(PracticalCode::WheelWrapper->wheel($args)->hello, "hello!");
  done_testing;
};

done_testing;
