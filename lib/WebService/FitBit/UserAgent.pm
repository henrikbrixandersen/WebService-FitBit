package WebService::FitBit::UserAgent;

use 5.008;
use strict;
use warnings;

use Carp;
use URI;
use URI::QueryParam;
use WebService::FitBit;

use Moo;
use namespace::clean;

extends 'LWP::Authen::OAuth';

for my $url (qw/request_token authorize authenticate access_token/) {
    has "fitbit_${url}_url" => (
        is => 'rw',
        builder => 1,
        isa => sub { croak 'Must be of type URI' unless $_[0]->isa('URI') },
    );
}

=head1 NAME

WebService::FitBit::UserAgent is an LWP::Authen::OAuth subclass for
authenticating and performing authenticated requests against
fitbit.com.

=head1 SYNOPSIS

  my $ua = WebService::FitBit::UserAgent->new;

  $ua->oauth_consumer_key($key);
  $ua->oauth_consumer_secret($secret);

  my $r = $ua->fitbit_request_token;
  if ($r->is_error) {
      # handle error
  }

  my $url = $ua->fitbit_authorize_redirect;

  # redirect user to $url and obtain $verifier

  $r = $ua->fitbit_request_access_token({verifier => $verifier});
  if ($r->is_success) {
      # $ua is now ready for performing authenticated requests
  } else {
      # handle error
  }

Please see L<LWP::Authen::OAuth> for full API details.

=head1 METHODS

=head2 $ua = WebService::FitBit::UserAgent->new(...)

Takes the same options as L<LWP::Authen::OAuth/new>.

=head2 $url = $ua-E<gt>fitbit_request_token_url([URL])

Get and optionally set the Fitbit C<Request Token> URL as an L<URI>
object. Default is L<https://api.fitbit.com/oauth/request_token>.

=cut

sub _build_fitbit_request_token_url {
    URI->new('https://api.fitbit.com/oauth/request_token');
}

=head2 $url = $ua-E<gt>fitbit_authorize_url([URL])

Get and optionally set the Fitbit C<Authorize> URL as an L<URI>
object. Default is L<https://www.fitbit.com/oauth/authorize>.

=cut

sub _build_fitbit_authorize_url {
    URI->new('https://www.fitbit.com/oauth/authorize');
}

=head2 $url = $ua-E<gt>fitbit_authenticate_url([URL])

Get and optionally set the Fitbit C<Authenticate> URL as an L<URI>
object. Default is L<https://www.fitbit.com/oauth/authenticate>.

=cut

sub _build_fitbit_authenticate_url {
    URI->new('https://www.fitbit.com/oauth/authenticate');
}

=head2 $url = $ua-E<gt>fitbit_access_token_url([URL])

Get and optionally set the Fitbit C<Access Token> URL as an L<URI>
object. Default is L<https://api.fitbit.com/oauth/access_token>.

=cut

sub _build_fitbit_access_token_url {
    URI->new('https://api.fitbit.com/oauth/access_token');
}

=head2 $response = $ua-E<gt>fitbit_request_token

Post a request for a C<Token> to the URL set using
C<< $ua->fitbit_request_token_url(...) >>.

The return value is an L<HTTP::Response> object.

=cut

sub fitbit_request_token {
    my $self = shift;

    my $r = $self->post($self->fitbit_request_token_url);
    $self->oauth_update_from_response($r) if ($r->is_success);

    return $r;
}

sub _fitbit_generic_redirect {
    my ($self, $url, @params) = @_;

    my $clone = $url->clone;
    $clone->query_form(@params) if (@params);

    $clone->query_param_delete('oauth_token');
    $clone->query_param_append('oauth_token' => $self->oauth_token);

    return $clone;
}

=head2 $response = $ua-E<gt>fitbit_authorize_redirect(...)

Returns an URL to be used for redirecting the user to the Fitbit
authorization page (referred to as C<Basic Workflow> in the Fitbit
API). It takes the same types of arguments for specifying additional
query parameters as L<URI/query_form>.

The following additional query parameters are documented in the Fitbit
API:

=over 4

=item * locale

=item * display

=item * requestCredentials

=back

The return value is an L<URI> object.

=cut

sub fitbit_authorize_redirect {
    my $self = shift;

    my $url = $self->_fitbit_generic_redirect($self->fitbit_authorize_url, @_);

    return $url;
}

=head2 $response = $ua-E<gt>fitbit_authenticate_redirect(...)

Returns an URL to be used for redirecting the user to the Fitbit
authentication page (referred to as C<Extended Workflow> in the Fitbit
API). It takes the same types of arguments for specifying additional
query parameters as L</fitbit_authorize_redirect>.

The return value is an L<URI> object.

=cut

sub fitbit_authenticate_redirect {
    my $self = shift;

    my $url = $self->_fitbit_generic_redirect($self->fitbit_authenticate_url, @_);

    return $url;
}

=head2 $response = $ua-E<gt>fitbit_request_token({verifier => $verifier})

Post a request for an C<Access Token> using the given OAuth
C<verifier> to the URL set using C<< $ua->fitbit_access_token_url(...) >>.

The return value is an L<HTTP::Response> object.

=cut

sub fitbit_request_access_token {
    my $self = shift;
    my $options = shift;

    my $r = $self->post($self->fitbit_access_token_url, [oauth_verifier => $options->{verifier}]);
    $self->oauth_update_from_response($r) if ($r->is_success);

    return $r;
}

sub _agent {
    my $self = shift;
    return "WebService::FitBit/$WebService::FitBit::VERSION " . $self->SUPER::_agent;
}

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

L<LWP::Authen::OAuth>, L<WebService::FitBit>, L<URI>,
L<HTTP::Response>, L<perlartistic>, L<perlgpl>

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
