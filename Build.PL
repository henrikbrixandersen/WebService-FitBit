#!/usr/bin/perl

use strict;
use warnings;

use Module::Build;

my $builder = Module::Build->new(
    module_name => 'WebService::Fitbit',
    dist_author => 'Henrik Brix Andersen <brix@cpan.org>',
    license  => 'perl',
    meta_merge => {
        resources => {
            repository => 'https://github.com/henrikbrixandersen/WebService-Fitbit',
        },
        keywords => ['webservice', 'fitbit'],
    },

    configure_requires => {
        'Module::Build' => '0.4004',
    },

    test_requires => {
        'Config' => '0',
        'Test::More' => '0',
    },

    requires => {
        'perl' => '5.006',
    },
);

$builder->create_build_script;
