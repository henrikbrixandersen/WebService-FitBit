#!/usr/bin/perl -w

use strict;

use Config;
use Test::More tests => 13;

BEGIN { use_ok('WebService::FitBit'); }

# Custom useragent
my $lwp = new_ok('LWP::UserAgent');
my $fitbit = new_ok('WebService::FitBit', [ useragent => $lwp ]);
can_ok($fitbit, 'useragent');
my $ua = $fitbit->useragent;
isa_ok($ua, 'LWP::UserAgent');
is($ua, $lwp);

# Default useragent
$fitbit = new_ok('WebService::FitBit');
$ua = $fitbit->useragent;
isa_ok($ua, 'WebService::FitBit::UserAgent');
isa_ok($ua, 'LWP::Authen::OAuth');
isa_ok($ua, 'LWP::UserAgent');

# URLs
foreach my $type (qw/request_token authorize access_token/) {
    can_ok($ua, "fitbit_${type}_url");
}
