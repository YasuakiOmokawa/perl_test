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
use SPVM 'SPVM::StringList';

# add search path to our modules
use FindBin;
use lib "$FindBin::Bin/../../lib";

# test module
use SPVM 'PracticalCode::Bicycle';

# begin test
my $strs = SPVM::StringList->new_len(0);
my $args = SPVM::Hash->new;
$strs->push('green'); $args->set(tape_color => $strs->shift);
$strs->push('S'); $args->set(size => $strs->shift);
$strs->push('road'); $args->set(style => $strs->shift);
$strs->push('Maitou'); $args->set(front_shock => $strs->shift);
$strs->push('Fox'); $args->set(rear_shock => $strs->shift);

subtest "new" => sub {
  my $bike = new PracticalCode::Bicycle($args);
  isa_ok($bike, 'PracticalCode::Bicycle');
  done_testing;
};

subtest "size" => sub {
  my $bike = new PracticalCode::Bicycle($args);
  is($bike->size, 'S');
  done_testing;
};

subtest "spares - road" => sub {
  my $bike = new PracticalCode::Bicycle($args);
  is($bike->spares->get("chain"), '10-speed');
  is($bike->spares->get_int("tire_size"), 23);
  is($bike->spares->get("tape_color"), $args->get("tape_color"));
  done_testing;
};

subtest "spares - mountain" => sub {
  $strs->push('mountain'); $args->set(style => $strs->shift);
  my $bike = new PracticalCode::Bicycle($args);
  is($bike->spares->get("chain"), '10-speed');
  is($bike->spares->get_double("tire_size"), 2.1);
  is($bike->spares->get("rear_shock"), $args->get("rear_shock"));
  done_testing;
};

done_testing;
