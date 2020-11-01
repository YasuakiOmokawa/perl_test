use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/lib";
use Benchmark qw/timethese cmpthese/;

use SPVM 'MyMath';

my $bench_count = 10_000;
my $loop_count = 1_00_000;
my $result = timethese($bench_count, {
  perl5_sum => sub {
    perl_sum($loop_count);
  },
  spvm_sum => sub {
    MyMath->spvm_sum($loop_count);
  },
  spvm_sum_precompile => sub {
    MyMath->spvm_sum_precompile($loop_count);
  },
  spvm_sum_native => sub {
    MyMath->spvm_sum_native($loop_count);
  },
});

cmpthese $result;

sub perl_sum {
  my ($loop_count) = @_;

  my $total = 0;
  for (my $i = 0; $i < $loop_count; $i++) {
    $total += $i;
  }

  return $total;
}