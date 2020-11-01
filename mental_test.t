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
use lib "$FindBin::Bin/lib";

# test module
use SPVM 'MentalTest';

# begin test
subtest "test" => sub {

  is(TRUE, 1, 'ok');

  done_testing;
};

done_testing;
