use strict;
use warnings;
use Router::Simple;
use Test::More;

my $r = Router::Simple->new();
$r->submapper(path_prefix => '/account', controller => 'Account')
      ->connect('/login', {action => 'login'})
      ->connect('/logout', {action => 'logout'});
$r->submapper('/entry/{id:[0-9]+}', controller => 'Entry')
      ->connect('/show', {action => 'show'})
      ->connect('/edit', {action => 'edit'});

is_deeply(
    $r->match( +{ PATH_INFO => '/account/login', HTTP_HOST => 'localhost', REQUEST_METHOD => 'GET' } ) || undef,
    {
        controller => 'Account',
        action     => 'login',
        args       => {},
    }
);
is_deeply(
    $r->match( +{ PATH_INFO => '/entry/49/edit', HTTP_HOST => 'localhost', REQUEST_METHOD => 'GET' } ) || undef,
    {
        controller => 'Entry',
        action     => 'edit',
        args       => {id=>49},
    }
);

done_testing;
