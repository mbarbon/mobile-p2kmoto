package Mobile::P2kMoto::FS::FileInfo;

use strict;
use warnings;

=head1 NAME

Mobile::P2kMoto::FS::FileInfo - file information for Motorola P2K phones

=head1 METHODS

=head2 id

  my $id = $info->id;

Returns an integer representing the internally-used id of the file.

=head2 name

  my $name = $info->name;

Returns the full path of the file.

=head2 size

  my $size = $info->size;

Returns the size in bytes of the file.

=head2 owner

  my $owner = $info->owner;

Returns an integer representing the owner of the file.

=head2 attributes

  my $attributes = $info->attributes;

Returns an integer representing the file attributes.

=head1 SEE ALSO

L<Mobile::P2kMoto>, L<Mobile::P2kMoto::FS>

=cut

1;
