package WebService::FitBit::UserAgent;

use 5.006;
use strict;
use warnings;

use parent 'LWP::Authen::OAuth';

=head1 NAME

WebService::FitBit::UserAgent - LWP::Authen::OAuth subclass for
accessing data on fitbit.com.

=head1 SYNOPSIS

C<WebService::FitBit::UserAgent> is a C<LWP::Authen::OAuth> subclass
prepared for performing authenticated requests to fitbit.com.

Please see L<LWP::Authen::OAuth> for API details.

=head1 AUTHOR

Henrik Brix Andersen, C<< <brix at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-webservice-fitbit at
rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=WebService-FitBit>.  I
will be notified, and then you'll automatically be notified of
progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc WebService::FitBit::UserAgent

You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=WebService-FitBit>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/WebService-FitBit>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/WebService-FitBit>

=item * Search CPAN

L<http://search.cpan.org/dist/WebService-FitBit/>

=back

=head1 SEE ALSO

L<LWP::Authen::OAuth>, L<WebService::FitBit>, L<perlartistic>,
L<perlgpl>

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

1; # End of WebService::FitBit::UserAgent
