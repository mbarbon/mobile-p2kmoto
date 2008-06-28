#!/usr/bin/perl -w

use strict;
use warnings;
use lib 'inc';

use ExtUtils::MakeMaker;
use Devel::CheckLib;

my $check_lib = !grep /--no-check-lib/, @ARGV;
check_lib_or_exit( lib => 'p2kmoto', header => 'p2kmoto.h' )
    if $check_lib;

eval {
    require ExtUtils::MY_Metafile;
    ExtUtils::MY_Metafile->import;

    my_metafile
      ( { license        => 'gpl',
          dynamic_config => 0,
          } );
};

WriteMakefile
  ( NAME               => 'Mobile::P2kMoto',
    VERSION_FROM       => 'lib/Mobile/P2kMoto.pm',
    PREREQ_PM          => { 'XSLoader' => '0.01',
                            },
    ( $] >= 5.005 ?
      ( ABSTRACT_FROM  => 'lib/Mobile/P2kMoto.pm',
        AUTHOR         => 'Mattia Barbon <mbarbon@cpan.org>' ) : () ),
    LIBS               => [ '-lp2kmoto' ],
    clean              => { FILES => 'const-c.inc const-xs.inc' },
);
if( eval { require ExtUtils::Constant; 1 } ) {
    # If you edit these definitions to change the constants used,
    # you will need to use the generated const-c.inc and const-xs.inc
    # files to replace their "fallback" counterparts before distributing your
    # changes.
    use lib qw(lib);
    use Mobile::P2kMoto::Constants;
    ExtUtils::Constant::WriteConstants
        ( NAME         => 'Mobile::P2kMoto',
          NAMES        => \@Mobile::P2kMoto::Constants::CONSTANTS,
          DEFAULT_TYPE => 'IV',
          C_FILE       => 'const-c.inc',
          XS_FILE      => 'const-xs.inc',
          );
} else {
    use File::Copy;
    use File::Spec;

    foreach my $file ( 'const-c.inc', 'const-xs.inc' ) {
        my $fallback = File::Spec->catfile( 'fallback', $file );
        copy( $fallback, $file ) or die "Can't copy $fallback to $file: $!";
    }
}
