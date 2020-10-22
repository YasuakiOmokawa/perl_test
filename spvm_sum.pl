#! /usr/bin/env perl
use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/lib";

use SPVM 'MyMath';
use SPVM 'MySmpl';

# Call with normal data
my $total = MyMath->sum([3,6,8,9]);
print "Total: $total\n";

# Call With packed data
my $nums_packed = pack('l*', 3, 6, 8, 9);
my $sv_nums = SPVM::new_int_array_from_bin($nums_packed);
my $total_packed = MyMath->sum($sv_nums);
print "Total Packed: $total_packed\n";

# Call My Sample routine
my $total2 = MySmpl->sum([3,6,8,9]);
print "Total2: $total2\n";
