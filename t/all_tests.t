use strict;
use Test;

use List::Utils qw(:all);
use Data::Dumper;

BEGIN { plan tests => 7 }

my @all_true = (1..400);
my @all_false = ("", undef, 0);
my @notall_true = (42,42,42,0,42,42,42,0);
my @violent_femme = qw(this must be hallowed ground);

#1
ok(all(@all_true));

#2
ok(none(@all_false));

#3
ok(notall(@notall_true));

#4
ok(true(@notall_true),6);

#5
ok(false(@notall_true),2);

#6
ok(index_for_which(sub { shift() eq 'hallowed' }, \@violent_femme), 3);

#7
ok(index_for_which(sub { shift() eq 'this' }, \@violent_femme), 0);

my $r = insert_after_string ('be', 'very', \@violent_femme);

my $I = index_for_which(sub { length(shift()) == 8 }, \@violent_femme);
   $r = _insert_after ($I,
		      'compound_insert',
		      \@violent_femme
		     );

#warn Dumper($r);

   $r = insert_after (sub { length(shift()) == 8 },
		       'second_innsert',
		       \@violent_femme
		      );

#warn Dumper($r);

