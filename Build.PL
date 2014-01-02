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

    test_requires => {
        'Config' => '0',
        'LWP::Authen::OAuth' => '1.02',
        'REST::Client' => '271',
        'Test::More' => '0',
        'URI' => '1.60',
    },

    requires => {
        'perl' => '5.006',
        'LWP::Authen::OAuth' => '1.02',
        'REST::Client' => '271',
        'URI' => '1.60',
    },
);

$builder->create_build_script;
