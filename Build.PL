#!/usr/bin/perl

use strict;
use warnings;

use Module::Build;

my $builder = Module::Build->new(
    module_name => 'WebService::FitBit',
    dist_author => 'Henrik Brix Andersen <brix@cpan.org>',
    license  => 'perl',
    meta_merge => {
        resources => {
            repository => 'https://github.com/henrikbrixandersen/WebService-FitBit',
        },
        keywords => ['webservice', 'fitbit'],
    },

    configure_requires => {
        'Module::Build' => '0.4004',
    },

    requires => {
        'perl' => '5.008',
        'LWP::Authen::OAuth' => '1.02',
        'Moo' => '1.004002',
        'URI' => '1.60',
    },

    test_requires => {
        'Config' => '0',
        'Test::More' => '0',
    },
);

$builder->create_build_script;
