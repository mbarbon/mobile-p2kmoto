#!/usr/bin/perl -w

use strict;
use warnings;
use blib;
use Mobile::P2kMoto;
use File::Basename qw();

use constant TIMEOUT => 3000;

print 'Open: ', Mobile::P2kMoto::easy_openPhone( timeout => TIMEOUT ), "\n";

for(;;) {
    print "> ";
    my $cmd = <>;
    chomp $cmd;
    $cmd =~ s/^\s*(\w+)\s*//;
    my $sub = main->can( $1 );

    next unless $sub;
    $sub->( $1, $cmd );
}

sub close {
    my( $cmd, $arg ) = @_;

    print 'Close: ', Mobile::P2kMoto::closePhone(), "\n";
}

sub quit {
    my( $cmd, $arg ) = @_;

    exit 0;
}

sub reboot {
    my( $cmd, $arg ) = @_;

    print 'Reboot: ', Mobile::P2kMoto::reboot(), "\n";
}

sub ls {
    my( $cmd, $arg ) = @_;
    my @files = Mobile::P2kMoto::FS::dir( $arg );

    print $_->size, "\t", $_->attributes, "\t", $_->name, "\n" foreach @files;
}

sub get {
    my( $cmd, $arg ) = @_;
    my( $file ) = Mobile::P2kMoto::FS::dir( $arg );

    unless( $file ) {
        warn "No file found";
        return;
    }

    my $to = File::Basename::basename( $arg );
    my $fh = Mobile::P2kMoto::FS::open( $arg, $file->attributes, $file->size );

    open my $out, '>', $to;
    for(;;) {
        my $buf;
        last if read( $fh, $buf, 10000 ) <= 0;

        print $out $buf;
    }
    CORE::close $out;
    CORE::close $fh;
}

sub put {
    my( $cmd, $arg ) = @_;
    my( $from, $to ) = split ' ', $arg;

    require File::Copy;

    my $out = Mobile::P2kMoto::FS::open( $from, 0, 0 );
    open my $in, '<', $from;

    for(;;) {
        my $buf = '';
        last if read( $in, $buf, 10000 ) == 0;
        print $out $buf;
    }
}

sub rm {
    my( $cmd, $arg ) = @_;

    Mobile::P2kMoto::FS::delete( $arg );
}

sub mkdir {
    my( $cmd, $arg ) = @_;

    Mobile::P2kMoto::FS::createDir( $arg );
}

sub rmdir {
    my( $cmd, $arg ) = @_;

    Mobile::P2kMoto::FS::removeDir( $arg );
}

1;
