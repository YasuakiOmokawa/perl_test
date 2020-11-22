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
$args->set_int(rim => 26);
$args->set_float(tire => 1.5);

subtest "new" => sub {
  my $wheel = PracticalCode::WheelWrapper->wheel($args);
  isa_ok($wheel, 'PracticalCode::Vendor::Wheel');
  done_testing;
};

# subtest "circumference" => sub {
#   my $wheel = new PracticalCode::Wheel($args);
#   is($wheel->circumference, 91.106186954104);
#   done_testing;
# };

done_testing;
