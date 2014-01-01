#!/usr/bin/perl -w

use strict;

use Config;
use Test::More tests => 11;

BEGIN { use_ok('WebService::FitBit'); }
my $fitbit = new_ok('WebService::FitBit');
isa_ok($fitbit, 'WebService::FitBit');

can_ok($fitbit, 'useragent');

my $ua = $fitbit->useragent;
isa_ok($ua, 'WebService::FitBit::UserAgent');
isa_ok($ua, 'LWP::Authen::OAuth');
isa_ok($ua, 'LWP::UserAgent');

my $lwp = new_ok('LWP::UserAgent');
$fitbit = new_ok('WebService::FitBit', [ useragent => $lwp ]);
$ua = $fitbit->useragent;
isa_ok($ua, 'LWP::UserAgent');
is($ua, $lwp);
