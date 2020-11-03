use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/lib";
use Benchmark qw/timethese cmpthese/;

use SPVM 'MentalTest';

my $mental_test = new MentalTest(5);
my $bench_count = 10_000;
my $result = timethese($bench_count, {
  perl5_reversed_score => sub {
    perl5_reversed_score(5);
  },
  spvm_reversed_score => sub {
    $mental_test->reversed_score(5);
  },
});

cmpthese $result;

sub perl5_reversed_score {
  my ($score) = @_;
  my @scales = qw/5 4 3 2 1/;
  return $scales[$score - 1];
}