package Mobile::P2kMoto::FS::FH;

use strict;
use warnings;
use base qw(Tie::Handle);

=head1 NAME

Mobile::P2kMoto::FS::FH - internal class used by Mobile::P2kMoto::FS::open

=cut

sub TIEHANDLE {
    my( $class, $size ) = @_;
    my $self = bless { size => $size, offset => 0 }, $class;

    return $self;
}

sub READ {
    my( $self, undef, $length, $offset ) = @_;
    my( $buf, $res ) = ( '', '' );
    my $remain = $self->{size} - $self->{offset};

    $length = $remain if $remain < $length;

    while( $length ) {
        my $to_read = $length > 1024 ? 1024 : $length;
        my $ok = Mobile::P2kMoto::FS::read( $buf, $to_read );

        if( $ok == 0 ) {
            $res .= $buf;
            $length -= $to_read;
            $self->{offset} += $to_read;
        } else {
            last;
        }
    }

    if( @_ == 4 ) {
        substr( $_[1], $offset ) = $res;
    } else {
        $_[1] = $res;
    }

    return length( $res );
}

#sub READLINE {
#}

sub WRITE {
    my( $self, $buf, $length, $offset ) = @_;

    $buf = substr( $_[1], @_[2 .. 3] ) if @_ > 2;
    $length = length( $buf );

    my $written = 0;
    while( $length ) {
        my $to_write = $length > 1024 ? 1024 : $length;
        my $ok = Mobile::P2kMoto::FS::write( substr( $buf, $written, $to_write ), $to_write );

        if( $ok == 0 ) {
            $written += $to_write;
            $length -= $to_write;
            $self->{offset} += $to_write;
            $self->{size} = $self->{offset} if $self->{offset} > $self->{size};
        } else {
            last;
        }
    }

    return $written;
}

sub CLOSE {
    my( $self ) = @_;

    delete $self->{offset};
    delete $self->{size};

    return Mobile::P2kMoto::FS::close() == 0;
}

sub EOF {
    my( $self ) = @_;

    return $self->{offset} == $self->{size};
}

sub SEEK {
    my( $self, $pos, $whence ) = @_;

    if( Mobile::P2kMoto::FS::seek( $pos, $whence ) == 0 ) {
        if( $whence == 0 ) {
            $self->{offset} = $pos;
        } elsif( $whence == 1 ) {
            $self->{offset} += $pos;
        } elsif( $whence == 2 ) {
            $self->{offset} = $self->{size} - $pos;
        }

        return 1;
    } else {
        return 0;
    }
}

sub TELL {
    my( $self ) = @_;

    return $self->{offset};
}

sub FILENO { die "No low-level filehandle" }

1;
