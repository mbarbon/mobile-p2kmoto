#!/usr/bin/perl -w

use strict;
use warnings;
use blib;
use Mobile::P2kMoto;

use constant TIMEOUT => 3000;

print 'Detect: ', Mobile::P2kMoto::detectPhone(), "\n";
my $state = Mobile::P2kMoto::findPhone();
die "No phone found" if $state == Mobile::P2kMoto::P2K_PHONE_NONE();
print "State $state\n";
if( $state == Mobile::P2kMoto::P2K_PHONE_AT() ) {
    print 'Set P2K: ', Mobile::P2kMoto::setP2Kmode( TIMEOUT ), "\n";
}

print 'Open: ', Mobile::P2kMoto::openPhone( TIMEOUT ), "\n";
print 'Search: ', Mobile::P2kMoto::FS::searchRequest( '/a/*.wav' ), "\n";

sub cb {
    print $_[0]->name, "\n";
}
print 'List: ', Mobile::P2kMoto::FS::fileList( \&cb ), "\n";

1;
