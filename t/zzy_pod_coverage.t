#!/usr/bin/perl -w

use strict;
use Test::More;
eval "use Test::Pod::Coverage 1.00";
plan skip_all => "Test::Pod::Coverage 1.00 required for testing POD coverage"
  if $@;
plan( tests => 3 );
pod_coverage_ok( 'Mobile::P2kMoto', { trustme => [ qr/^(constant|init)$/ ] } );
pod_coverage_ok( 'Mobile::P2kMoto::FS' );
pod_coverage_ok( 'Mobile::P2kMoto::FS::FileInfo' );
