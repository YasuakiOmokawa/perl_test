#! /usr/bin/env perl
use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/lib";

use SPVM 'MyMath';
use SPVM 'MySmpl';

# Call with normal data
my $total = MyMath->spvm_arr_sum([3,6,8,9]);
print "Total: $total\n";

# Call With packed data
my $nums_packed = pack('l*', 3, 6, 8, 9);
my $sv_nums = SPVM::new_int_array_from_bin($nums_packed);
my $total_packed = MyMath->spvm_arr_sum($sv_nums);
print "Total Packed: $total_packed\n";

# Call with faster
my $loop_count = 10_000;
my $pre_total = MyMath->spvm_sum_precompile($loop_count);
print "Total Precompiled: $pre_total\n";
my $native_total = MyMath->spvm_sum_native($loop_count);
print "Total Native: $native_total\n";

# Call with scaled calculator
