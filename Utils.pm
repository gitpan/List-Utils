package List::Utils;

require 5.005_62;
use strict;
use warnings;
use diagnostics;

use Carp qw(confess);
use Data::Dumper;

require Exporter;

our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use List::Utils ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(all none notall true false

				   index_for_which

				   _insert_after
				   insert_after

				   insert_after_string

) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	
);
our $VERSION = '0.05';


# Preloaded methods go here.

# All arguments are true
sub all { $_ || return 0 for @_; 1 }


# All arguments are false
sub none { $_ && return 0 for @_; 1 }


# One argument is false
sub notall { $_ || return 1 for @_; 0 }


# How many elements are true
sub true { scalar grep { $_ } @_ }


# How many elements are false
sub false { scalar grep { !$_ } @_ }

sub index_for_which {

    my $sub = shift or confess 'must supply sub';
    my $i = 0;
    my $array = shift;
    for (@$array) {
	return $i if $sub->($_);
	++$i;
    }

    return undef;
}

sub _insert_after {

    my ($i, $new_val, $a) = @_;

    defined ($i) or die "could not use $i to insert_after";

    my   @n =  @{$a}[0 .. $i];
#    warn Dumper(\@n);
    push @n,   $new_val;
#    warn Dumper(\@n);
    push @n,   @{$a}[$i+1 .. $#$a];


    return \@n;

}

sub insert_after {

    my ($sub, $string, $array) = @_;

    _insert_after (
		   (index_for_which $sub, $array),
		   $string,
		   $array
		  );

}

sub insert_after_string {

    my ($search, $new_val, $a) = @_;

    my $i = index_for_which (
			     sub { shift() eq $search },
			     $a);

    defined ($i) or die "could not find $search in @_";

    return _insert_after($i, $new_val, $a);


#    warn "i: $i";

    my @n =  @{$a}[0 .. $i];

#    warn "list so far: ", Dumper(\@n, $a);


#    warn "pushing $new_val";

    push @n, $new_val;

#    warn "list after push: ", Dumper(\@n);

    push @n, @{$a}[$i+1 .. $#$a];


}

1;
__END__
# Below is stub documentation for your module. You better edit it!

=head1 NAME

List::Utils - Additional list utilities

=head1 SYNOPSIS

 use List::Utils qw(:all);

 print 'all "true", so to speak'  if all(@data);
 print 'none true' if none(@data);
 print 'at least 1 false' if notall(@data);
 if (notall(@data)) {
    printf "as a matter of fact, %d are true and %d are false", 
    true(@data), false(@data);
 }

 ok(index_for_which(sub { shift() eq 'hallowed' }, @violent_femme), 3);

 for (@required_fields) {
    my $search = $_;
    $required_fields_i{$_} =
      index_for_which ( sub { shift() eq $search }, $R );
 }


 my $I = index_for_which(sub { length(shift()) == 8 }, \@violent_femme);
 my $r = _insert_after ($I,
		      'compound_insert',
		      \@violent_femme
		     );
 # easier
 my $r = insert_after (sub { length(shift()) == 8 },
		       'second_innsert',
		       \@violent_femme
		      );

 # easiest
 my $r = insert_after_string ('be', 'very', \@violent_femme);



=head1 DESCRIPTION

You know the things that Graham said could be implemented in Perl in
the List::Util (part of Scalar::List::Util release) docs but didn't? Well, 
here they are.

=over 4

=item * C<all> returns true if all arguments are true

=item * C<none> returns true if all arguments are false

=item * C<notall> returns true if any argument is false

=item * C<true> returns how many elements are true

=item * C<false> returns how many elements are false

=back

=head1 TODO

 C<insert_before> must be written... for obvious reasons.

=head2 EXPORT

None by default. C<use List::Utils qw(:all)> to import all subs.

=head1 AUTHOR

T. M. Brannon, <tbone@cpan.org>

=head1 SEE ALSO

perl(1).

=cut
