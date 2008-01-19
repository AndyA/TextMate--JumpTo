use strict;
use warnings;
use ExtUtils::MakeMaker;

require 5.008006;

my $TEXTMATE = '/Applications/TextMate.app';

unless ( $^O =~ /darwin/ ) {
    warn "TextMate::JumpTo only runs on Mac OS\n" . "Can't continue\n";
    exit 0;    # == NA test result
}

unless ( -d $TEXTMATE ) {
    warn "$TEXTMATE doesn't exist. Maybe your TextMate is installed\n"
      . "somewhere else. That's not a problem unless you don't have\n"
      . "TextMate installed at all. This module needs TextMate in\n"
      . "order to work.\n";
}

eval 'use ExtUtils::MakeMaker::Coverage';

WriteMakefile(
    ( MM->can( 'signature_target' ) ? ( SIGN => 1 ) : () ),
    NAME          => 'TextMate::JumpTo',
    AUTHOR        => 'Andy Armstrong <andy@hexten.net>',
    LICENSE       => 'perl',
    VERSION_FROM  => 'lib/TextMate/JumpTo.pm',
    ABSTRACT_FROM => 'lib/TextMate/JumpTo.pm',
    PL_FILES      => {},
    PREREQ_PM     => {
        'Test::More'        => 0,
        'Test::Differences' => '0.47',
        'HTML::Tiny'        => '1.01',
        'File::Spec'        => 0,
    },
    dist  => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean => { FILES    => 'TextMate-JumpTo-*' },
);
