package Mobile::P2kMoto;

use 5.006;
use strict;
use warnings;

use Mobile::P2kMoto::FS;
use Mobile::P2kMoto::FS::FileInfo;

our $VERSION = '0.02';
our $AUTOLOAD;

sub AUTOLOAD {
    (my $constname = $AUTOLOAD) =~ s/.*:://;
    my ($error, $val) = constant($constname);
    if ($error)
    {
	require Carp;
	Carp::croak($error);
    }

    no strict 'refs';
    *$AUTOLOAD = sub { $val };
    goto &$AUTOLOAD;
}

require XSLoader;
XSLoader::load('Mobile::P2kMoto', $VERSION);

init();

sub easy_openPhone {
    my( %args ) = @_;

    $args{timeout} ||= 3000;
    $args{device}  ||= '/dev/ttyACM0';

    Mobile::P2kMoto::setACMdevice( $args{device} );
    if( $args{at_config} && $args{p2k_config} ) {
        Mobile::P2kMoto::setATconfig( @{$args{at_config}} );
        Mobile::P2kMoto::setP2Kconfig( @{$args{p2k_config}} );
    } else {
        Mobile::P2kMoto::detectPhone();
    }

    my $state = Mobile::P2kMoto::findPhone();

    if( $state == Mobile::P2kMoto::P2K_PHONE_NONE() ) {
        die "No phone found";
    } elsif( $state == Mobile::P2kMoto::P2K_PHONE_AT() ) {
        Mobile::P2kMoto::setP2Kmode( $args{timeout} )
            and die "Failed to set P2K mode";
    } elsif( $state == Mobile::P2kMoto::P2K_PHONE_P2K() ) {
        # do nothing, all is well
    }

    return Mobile::P2kMoto::openPhone( $args{timeout} );
}

1;

__END__

=head1 NAME

Mobile::P2kMoto - interface with Motorola P2K phones

=head1 SYNOPSIS

    use Mobile::P2kMoto;
    use constant TIMEOUT => 3000;

    Mobile::P2kMoto::easy_openPhone( device  => '/dev/ttyACM0',
                                     timeout => TIMEOUT,
                                     );

    Mobile::P2kMoto::FS::searchRequest( '/a/*.wav' );
    Mobile::P2kMoto::FS::fileList( sub { print $_[0]->name, "\n" } );

=head1 DESCRIPTION

This module uses the p2kmoto library to interface with Motorola Mobile
phones using an USB cable.

=head1 FUNCTIONS

=head2 setACMdevice

  setACMdevice( "/dev/ttyACM1" );

The p2kmoto library uses F</dev/ttyACM0> (for Unix) and F<COM3> (for
Win32) as the default device, use this function to change it.

=head2 detectPhone

  my $rv = detectPhone();

Tries to auto-sense a phone connected to the current ACM device.  If
succesful, automatically calls C<setATconfig()> and C<setP2kconfig()>.

=head2 findPhone

  my $rv = findPhone();

Detects current phone state.  Returns one of C<P2K_PHONE_NONE>,
C<P2K_PHONE_AT>, C<P2K_PHONE_P2K>.

=head2 setP2Kmode

  my $rv = setP2Kmode( $timeout );

If the phone is in AT mode, switches it to P2K mode.  Must be called
before accessing the phone via C<openPhone()>.

=head2 openPhone

  my $rv = openPhone( $timeout );

Connects to the phone.  The phone must be in P2K mode before
performing this action.

=head2 easy_openPhone

  my $rv = easy_openPhone( device     => '/dev/ttyACM0',
                           timeout    => 3000,
                           p2k_config => [ 0x1, 0x2 ],
                           acm_config => [ 0x3, 0x4 ],
                           );

A simplified interface to configuring/detecting/opening the phone:
C<device> defaults to C<'/dev/ttyACM0'> and C<timeout> to C<3000>;
C<p2k_config> and C<acm_config> are optional.

This function performa several actions: first it sets the ACM device;
if C<p2k_config> and C<acm_config> are specified, calls
C<setP2Kconfig> and C<setACMconfig>, otherwise calls C<detectPhone>;
switched the phone to P2K mode if it isn't already; calls
C<openPhone>.

=head2 closePhone

  my $rv = closePhone();

Closes the connection to the phone.

=head2 suspend

  my $rv = suspend();

Suspends the phone.

=head2 reboot

  my $rv = reboot();

Reboots the phone.

=head1 CONFIGURATION FUNCTIONS

You should only need the functions below if autodetection fails and if
the defaults values provided by p2kmoto do not work for you.

=head2 setATconfig

  setATconfig( 0x22b8, 0x4902 );

Sets the vendor/product ID used by p2kmoto for the AT interface.

=head2 setP2Kconfig

  setP2Kconfig( 0x22b8, 0x4901 );

Sets the vendor/product ID used by p2kmoto for the P2K interface.

=head2 getACMdevice

  my $device = getACMdevice();

Returns the device used to connect to the phone.

=head2 getATproduct

  my $id = getATproduct();

Sets the product ID used by p2kmoto for the AT interface.

=head2 getATvendor

  my $id = getATvendor();

Sets the vendor ID used by p2kmoto for the AT interface.

=head2 getP2Kproduct

  my $id = getP2Kproduct();

Sets the product ID used by p2kmoto for the P2K interface.

=head2 getP2Kvendor

  my $id = getP2Kvendor();

Sets the vendor ID used by p2kmoto for the P2K interface.

=head1 SEE ALSO

L<Mobile::P2kMoto::FS>, L<Mobile::P2kMoto::FS::FileInfo>

=head1 AUTHOR

Mattia Barbon, E<lt>mbarbon@cpan.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2006-2007 by Mattia Barbon

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

=cut
