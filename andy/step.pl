#!/usr/bin/perl

use strict;
use warnings;
use lib qw(lib);

use TextMate::JumpTo qw(jumpto);

$| = 1;

my $file = 'lib/TextMate/JumpTo.pm';

for ( 1 .. 100 ) {
    jumpto( file => $file, line => $_, bg => 1 );
    sleep 1;
}
