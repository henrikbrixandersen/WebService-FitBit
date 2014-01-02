#!/usr/bin/perl -w

use strict;
use blib;

use WebService::FitBit;

my $fitbit = WebService::FitBit->new;

my $ua = $fitbit->useragent;
$ua->show_progress(1);

# Turn off SSL hostname verification, since we don't know if the user
# running this example script has access to an SSL CA file. Not
# recommended for production code!
$ua->ssl_opts(verify_hostname => 0);

print "Enter the application's Consumer Key: ";
my $key = <STDIN>;
chomp $key;
$ua->oauth_consumer_key($key);

print "Enter the application's Consumer Secret: ";
my $secret = <STDIN>;
chomp $secret;
$ua->oauth_consumer_secret($secret);

print "\nRequesting Token...\n";
my $r = $ua->fitbit_request_token;
die $r->status_line if ($r->is_error);
print "\n";

my $url = $ua->fitbit_authorize_redirect();
print "Now visit: $url\n";
print "Enter the Verifier obtained from the above URL: ";
my $verifier = <STDIN>;
chomp $verifier;

print "\nRequesting Access Token...\n";
$r = $ua->fitbit_request_access_token({verifier => $verifier});
if ($r->is_success) {
    print "Authenticated!\n"
} else {
    die $r->status_line;
}

