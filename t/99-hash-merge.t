#!perl

use strict;
use warnings;
use Test::More;
use Test::Deep;

use DBICx::DataDictionary::Expand ();
*main::hm = \&DBICx::DataDictionary::Expand::__merge_hash;

cmp_deeply(hm({a => 1}, {a => 2, b => 2}), {a => 1, b => 2});
cmp_deeply(hm({aa => 1}, {a => 2, b => 2}), {aa => 1, a => 2, b => 2});

done_testing();
