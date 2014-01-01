#!/usr/bin/perl -w

use strict;

use Config;
use Test::More tests => 3;

BEGIN { use_ok('WebService::FitBit'); }

diag("Testing WebService::FitBit $WebService::FitBit::VERSION, Perl $], $^X, OS $^O ($Config{'archname'})");

my $fitbit = new_ok('WebService::FitBit');
isa_ok($fitbit, 'WebService::FitBit');
