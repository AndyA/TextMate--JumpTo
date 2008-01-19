#!/usr/bin/perl

use strict;
use warnings;

$| = 1;

sub boggle {
    print "Boggle!\n";
}

for ( 1.. 100) {
    print "$_\n";
    chdir('..');
    boggle();
    eval q{
        print `pwd`;
        print "Aye!\n";
    };
}
