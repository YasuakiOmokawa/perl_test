use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/lib";
use Data::Dumper;

use SPVM 'MyCmplx2f';

my $c2f = MyCmplx2f->cmplx_2f;
print Dumper $c2f;