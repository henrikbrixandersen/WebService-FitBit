package WebService::Fitbit;

use 5.006;
use strict;
use warnings;

use WebService::Fitbit::UserAgent;

=head1 NAME

WebService::Fitbit - Perl module for accessing data on fitbit.com

=head1 VERSION

Version 0.10

=cut

our $VERSION = '0.10';

=head1 SYNOPSIS

C<WebService::Fitbit> provides an API for accessing data on
L<http://fitbit.com>.

=head1 METHODS

=head2 $fitbit = WebService::Fitbit->new([%config])

Construct a new C<WebService::Fitbit> object. Takes an optional hash
with the following keys:

=over 4

=item useragent

A L<WebService::Fitbit::UserAgent> object (or any other
L<LWP::UserAgent> subclass capable of performing OAuth authenticated
requests againt fitbit.com).

A default, unauthenticated L<WebService::Fitbit::UserAgent> instance
will be provided for you if this key is not specified.

=back

=cut

sub new {
    my $class = shift;
    my %config = @_;

    my $ua;
    if ($config{useragent}) {
        $ua = $config{useragent};
    } else {
        $ua = WebService::Fitbit::UserAgent->new;
    }

    my $self = {
        useragent => $ua,
    };
    bless $self, $class;

    return $self;
}

=head2 $ua = $fitbit->useragent()

Get the L<LWP::UserAgent> instance used for making authenticated
requests against fitbit.com, typically an instance of
L<WebService::Fitbit::UserAgent>.

=cut

sub useragent {
    my ($self) = @_;

    return $self->{useragent};
}

=head1 AUTHOR

Henrik Brix Andersen, C<< <brix at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-webservice-fitbit at
rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=WebService-Fitbit>.  I
will be notified, and then you'll automatically be notified of
progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc WebService::Fitbit

You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=WebService-Fitbit>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/WebService-Fitbit>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/WebService-Fitbit>

=item * Search CPAN

L<http://search.cpan.org/dist/WebService-Fitbit/>

=back

=head1 SEE ALSO

L<perlartistic>, L<perlgpl>

=head1 LICENSE AND COPYRIGHT

Copyright 2014 Henrik Brix Andersen.

This program is free software; you can redistribute it and/or modify
it under the terms of either:

=over 4

=item * the GNU General Public License as published by the Free
Software Foundation; either version 1, or (at your option) any
later version, or

=item * the "Artistic License" which comes with this Kit.

=back

=cut

1; # End of WebService::Fitbit
