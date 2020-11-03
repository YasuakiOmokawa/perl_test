use lib "t/../lib";

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
subtest "new" => sub {
  my $mental_test = new MentalTest(5);
  isa_ok($mental_test, 'MentalTest');

  done_testing;
};

subtest "reversed_score odd" => sub {
  my $mental_test = new MentalTest(5);
  is($mental_test->reversed_score(1), 5, 'first');
  is($mental_test->reversed_score(5), 1, 'last');
  is($mental_test->reversed_score(3), 3, 'middle');

  done_testing;
};

subtest "reversed_score even" => sub {
  my $mental_test = new MentalTest(6);
  is($mental_test->reversed_score(1), 6, 'first');
  is($mental_test->reversed_score(6), 1, 'last');
  is($mental_test->reversed_score(3), 4, 'middle');

  done_testing;
};

done_testing;
