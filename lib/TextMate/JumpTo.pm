package TextMate::JumpTo;

use warnings;
use strict;
use HTML::Tiny;
use File::Spec;
use Carp;

use base qw(Exporter);

our @EXPORT_OK = qw(jumpto);

=head1 NAME

TextMate::JumpTo - Tell TextMate to jump to a particular file, line

=head1 VERSION

This document describes TextMate::JumpTo version 0.02

=cut

our $VERSION = '0.02';

=head1 SYNOPSIS

    use TextMate::JumpTo qw(jumpto);
    
    jumpto( file => 'mysrc.pl', line => 123 );
  
=head1 DESCRIPTION

On Mac OS The TextMate editor handles urls of the form

    txmt://open?«arguments»

which cause it to jump to the file, line and column specified by the
arguments. This module is a simple wrapper which uses the Mac OS 'open'
command to send TextMate to the specified location.

I use it in my F<~/.perldb> to have TextMate track the current debugger
position. Here's what it looks like:

    $ cat ~/.perldb
    use TextMate::JumpTo qw(jumpto);

    sub afterinit {
        $trace |= 4;    # Enable watchfunction

        # Needed to work out where filenames are relative to
        chomp( $base_dir = `pwd` );
    }

    sub watchfunction {
        my ( $package, $file, $line ) = @_;
        $file = File::Spec->rel2abs( $file, $base_dir );
        jumpto( file => $file, line => $line, bg => 1 )
          if substr( $file, 0, length( $base_dir ) ) eq $base_dir;
    }

=head1 INTERFACE 

=head2 C<< jumpto >>

Instruct TextMate to jump to the specified file, line and column. The
arguments are a list of key, value pairs:

    jumpto( file => 'splendid.pl', line => 12, column => 3 );

Possible arguments are:

=over

=item * C<file>

The path to the file to go to.

=item * C<line>

The (one based) line number to go to.

=item * C<column>

The (one based) column to go to.

=item * C<bg>

True to leave TextMate in the background. By default a call to C<jumpto>
will bring TextMate to the foreground.

=back

=cut

sub jumpto {
    croak
      "Odd number of args to jumpto, needs a list of key => value pairs"
      if @_ % 2;
    my %args = @_;
    my $bg   = delete $args{bg};
    croak "You must supply one or more of file, line, column"
      unless grep defined $args{$_}, qw(file line column);
    if ( my $file = delete $args{file} ) {
        $args{url} = "file://" . File::Spec->rel2abs( $file );
    }
    _open( 'txmt://open?' . HTML::Tiny->new->query_encode( \%args ),
        $bg );
}

# Open a URL on Mac OS.
sub _open {
    my ( $url, $bg ) = @_;
    my @cmd = ( '/usr/bin/open', ( $bg ? ( '-g' ) : () ), $url );
    system @cmd and croak "Can't open $url ($?)";
}

1;
__END__

=head1 CONFIGURATION AND ENVIRONMENT
  
TextMate::JumpTo requires no configuration files or environment variables.

=head1 DEPENDENCIES

None.

=head1 INCOMPATIBILITIES

None reported.

=head1 BUGS AND LIMITATIONS

No bugs have been reported.

Please report any bugs or feature requests to
C<bug-textmate-jumpto@rt.cpan.org>, or through the web interface at
L<http://rt.cpan.org>.

=head1 AUTHOR

Andy Armstrong  C<< <andy@hexten.net> >>

=head1 LICENCE AND COPYRIGHT

Copyright (c) 2008, Andy Armstrong C<< <andy@hexten.net> >>.

This module is free software; you can redistribute it and/or
modify it under the same terms as Perl itself. See L<perlartistic>.
