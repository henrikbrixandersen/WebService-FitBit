#!/usr/bin/perl -w

use strict;

use Config;
use Test::More tests => 3;

BEGIN { use_ok('WebService::Fitbit'); }

diag("Testing WebService::Fitbit $WebService::Fitbit::VERSION, Perl $], $^X, OS $^O ($Config{'archname'})");

my $fitbit = new_ok('WebService::Fitbit');
isa_ok($fitbit, 'WebService::Fitbit');
