#!perl

use strict;
use warnings;
use lib 't/tlib';
use Test::More;
use Test::Deep;

use DBICx::DataDictionary qw( fetch_type );
use My::Schema::DataDictionary qw(PK NAME);

is(PK, 'My::Schema::DataDictionary::PK', "Imported 'PK' ok");
cmp_deeply(
  fetch_type(PK),
  { data_type         => 'integer',
    is_nullable       => 0,
    is_auto_increment => 1,
  }
);

is(NAME, 'My::Schema::DataDictionary::NAME', "Imported 'NAME' ok");
cmp_deeply(
  fetch_type(NAME),
  { data_type   => 'varchar',
    is_nullable => 0,
    size        => 100,
  }
);

ok(!defined(fetch_type('non-existing')),
  "fetch_type() returns 'undef' for an undeclared type");

done_testing();
