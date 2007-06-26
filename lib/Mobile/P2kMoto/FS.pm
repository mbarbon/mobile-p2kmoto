package Mobile::P2kMoto::FS;

use strict;
use warnings;

=head1 NAME

Mobile::P2kMoto::FS - filesystem access for Motorola P2K phones

=head1 DESCRIPTION

Functions for listing, creating, reading files and directories.  All
the functions must be called only after a succesful call to
C<openPhone()>.

B<IMPORTANT>: only one file can be open at a given time.

=head1 FUNCTIONS

=head2 open

  my $rv = open( "/a/foo", 0666 );

Opens or creates a file.  Note that since only one file can be opened
at the same time, the return vale is a status, not a file handle.
Make sure you always call C<close()> before calling C<open()> again.

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

=head2 fileList

  my $callback = sub { print $_[0]->name };
  my $rv = fileList( $callback );

Calls C<$callback> for every file in the file list.  If
C<searchRequest()> was not called, lists every file, otherwise only the
ones matched by the last C<searchRequest()>.  The first and only
argument to the callback is a L<Mobile::P2kMoto::FS::FileInfo> object.

=head2 createDir

  my $rv = createDir( "/a/foodir" );

Creates the directory.

=head2 removeDir

  my $rv = removeDir( "/a/foodir" );

Removes the given directory.  The directory must be empty.

=head2 getVolumeFreeSpace

  my $space = getVolumeFreeSpace( "/a" );

Returns the free space on the volume (in bytes).

=cut

1;
