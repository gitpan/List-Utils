use strict;
use Test;

use List::Utils qw(:all);
use Data::Dumper;

BEGIN { plan tests => 5 }

my @all_true = (1..400);
my @all_false = ("", undef, 0);
my @notall_true = (42,42,42,0,42,42,42,0);

ok(all(@all_true));
ok(none(@all_false));
ok(notall(@notall_true));
ok(true(@notall_true),6);
ok(false(@notall_true),2);
