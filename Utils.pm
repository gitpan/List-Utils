package List::Utils;

require 5.005_62;
use strict;
use warnings;

require Exporter;

our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

# This allows declaration	use List::Utils ':all';
# If you do not need this, moving things directly into @EXPORT or @EXPORT_OK
# will save memory.
our %EXPORT_TAGS = ( 'all' => [ qw(all none notall true false) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	
);
our $VERSION = '0.01';


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

=head2 EXPORT

None by default. C<use List::Utils qw(:all)> to import all subs.

=head1 AUTHOR

T. M. Brannon, <tbone@cpan.org>

=head1 SEE ALSO

perl(1).

=cut
