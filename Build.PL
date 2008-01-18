use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name       => 'TextMate::JumpTo',
    license           => 'perl',
    dist_author       => 'Andy Armstrong <andy@hexten.net>',
    dist_version_from => 'lib/TextMate/JumpTo.pm',
    requires          => {
        'Test::More' => 0,
    },
    add_to_cleanup => ['TextMate-JumpTo-*'],
);

$builder->create_build_script();
