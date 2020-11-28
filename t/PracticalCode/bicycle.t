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
$strs->push('green');
my $args = SPVM::Hash->new;
$args->set(tape_color => $strs->shift);
$args->set_int(size => 26);

subtest "new" => sub {
  my $bike = new PracticalCode::Bicycle($args);
  isa_ok($bike, 'PracticalCode::Bicycle');
  done_testing;
};

subtest "size" => sub {
  my $bike = new PracticalCode::Bicycle($args);
  is($bike->size, 26);
  done_testing;
};

subtest "spares" => sub {
  my $bike = new PracticalCode::Bicycle($args);
  is($bike->spares->get_int("tire_size"), 23);
  is($bike->spares->get("tape_color"), 'red');
  done_testing;
};

done_testing;
