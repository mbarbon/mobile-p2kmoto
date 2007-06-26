#!/usr/bin/perl -w

use strict;
use Test::More tests => 1;

use Mobile::P2kMoto;
use Mobile::P2kMoto::Constants;

my $fail = 0;
foreach my $constname ( @Mobile::P2kMoto::Constants::CONSTANTS ) {
    next if eval "my \$a = Mobile::P2kMoto::$constname(); 1";
    if( $@ =~ /^Constant Mobile::P2kMoto::$constname not defined/ ) {
        diag( "pass: $@" );
    } else {
        diag( "fail: $@" );
	$fail = 1;
    }
}

ok( $fail == 0 , 'Constants' );
