package Mobile::P2kMoto::FS;

use strict;
use warnings;

sub open {
    my( $file, $mode, $size ) = @_;
    my $rv = _open( $file, $mode );

    require Symbol;
    require Mobile::P2kMoto::FS::FH;

    my $fh = Symbol::gensym();
    tie *$fh, 'Mobile::P2kMoto::FS::FH', $size;

    return $fh;
}

sub dir {
    my( $pattern ) = @_;
    my( $search ) = $pattern;

    my $cb;
    my @files;

    if( $search =~ m{^(?:/[a-zA-Z]/)?[^/]*$} ) {
        $cb = sub { push @files, $_[0] };
    } else {
        $search =~ s{^(/[a-zA-Z]/)?.*/}{$1};
        $pattern =~ s{\*}{.*}g;
        $cb = sub { push @files, $_[0] if $_[0]->name =~ $pattern };
    }

    return () if Mobile::P2kMoto::FS::searchRequest( $search ) < 0;
    return () if Mobile::P2kMoto::FS::fileList( $cb ) < 0;

    return @files;
}

=head1 NAME

Mobile::P2kMoto::FS - filesystem access for Motorola P2K phones

=head1 DESCRIPTION

Functions for listing, creating, reading files and directories.  All
the functions must be called only after a succesful call to
C<openPhone()>.

B<IMPORTANT>: only one file can be open at a given time.

=head1 FUNCTIONS

=head2 open

  my $fh = open( "/a/foo", 0, $size );

Opens or creates a file, returning a Perl filehandle.  Only one file
can be opened at the same time.  Make sure you always call C<close()>
before calling C<open()> again.

Due to the poor interface offered by the C<p2kmoto> library, when
opening a file for reading or updating, the starting size of the file
must be specified.  This might be fixed in the future.

=head2 _open

  my $rv = _open( "/a/foo", 0 );

Opens or creates a file.  Note that since only one file can be opened
at the same time, the return value is a status, not a file handle.
Make sure you always call C<close()> before calling C<open()> again.

This maps directly to the C<p2k_FSAC_open()> function.

Use C<open()> unless you know you need this function.

=head2 close

  my $rv = close();

Closes the currently-open file.

=head2 read

  my $rv = read( $buffer, $size );

Reads C<$size> bytes from the currently-opened file into C<$buffer>.
C<$size> but be less-or-equal than 1024.

=head2 write

  my $rv = write( $buffer, $size );

Write C<$size> bytes from the C<$buffer> info the currently-opened
file.  C<$size> but be less-or-equal than 1024.

=head2 seek

  my $rv = seek( $offset, $whence );

Seeks on the currently-open file.  C<$whence> can be one of
C<P2K_SEEK_BEGIN>, C<P2K_SEEK_CURRENT>, C<P2K_SEEK_END>.  C<$size> but
be less-or-equal than 1024.

=head2 delete

  my $rv = delete( "/a/foo" );

Removes the given file.

=head2 searchRequest

  my $count = searchRequest( "/a/*.mp3" );

Performs a search in the filesystem.  The results can be read using
C<fileList()>.  Note that the search is always recursive.  Returns the
number of files matching the request.

Valid patterns are F<*.foo> and F</c/*.foo>.

=head2 fileList

  my $callback = sub { print $_[0]->name };
  my $rv = fileList( $callback );

Calls C<$callback> for every file in the file list.  If
C<searchRequest()> was not called, lists every file, otherwise only the
ones matched by the last C<searchRequest()>.  The first and only
argument to the callback is a L<Mobile::P2kMoto::FS::FileInfo> object.

=head2 dir

  my @fileinfo = dir( "/a/*.mp3" );

Internally does a call to C<searchRequest> and C<fileList> and returns
a list of L<Mobile::P2kMoto::FS::FileInfo> as result.  Will try to handle
patterns more complicated than those supported by plain C<searchRequest>.

=head2 createDir

  my $rv = createDir( "/a/foodir" );

Creates the directory.

=head2 removeDir

  my $rv = removeDir( "/a/foodir" );

Removes the given directory.  The directory must be empty.

=head2 getVolumeFreeSpace

  my $space = getVolumeFreeSpace( "/a" );

Returns the free space on the volume (in bytes).

=head1 SEE ALSO

L<Mobile::P2kMoto>, L<Mobile::P2kMoto::FS::FileInfo>

=cut

1;
