#!perl

use strict;
use warnings;
use lib 't/tlib';
use Test::More;
use Test::Deep;

use My::Schema::DataDictionary qw(
  PK NAME SHORT_NAME VISIBILITY
  XPTO BASE_DATE OTHER_DATE
);

cmp_deeply(
  PK,
  { data_type         => 'integer',
    is_nullable       => 0,
    is_auto_increment => 1,
  }
);

cmp_deeply(
  PK(is_nullable => 1),
  { data_type         => 'integer',
    is_nullable       => 1,
    is_auto_increment => 1,
  }
);

cmp_deeply(
  NAME,
  { data_type   => 'varchar',
    is_nullable => 0,
    size        => 100,
  }
);

cmp_deeply(
  NAME('extra.formatter' => sub { }),
  { data_type   => 'varchar',
    is_nullable => 0,
    size        => 100,
    extra       => {formatter => ignore()},
  }
);

cmp_deeply(
  SHORT_NAME,
  { data_type   => 'varchar',
    is_nullable => 0,
    size        => 40,
  }
);

cmp_deeply(
  NAME(size => 200),
  { data_type   => 'varchar',
    is_nullable => 0,
    size        => 200,
  }
);

cmp_deeply(
  VISIBILITY,
  { data_type => 'varchar',
    size      => 32,
    extra     => {options => [qw( ab cd )]},
  }
);

cmp_deeply(
  XPTO,
  { data_type => 'varchar',
    size      => 20,
    extra     => {default => ignore()},
  }
);
is(XPTO->{extra}{default}->(), 'xpto is here');

cmp_deeply(
  XPTO(default => 'defme', options => ['a', 'b']),
  { data_type => 'varchar',
    size      => 20,
    extra     => {default => 'defme', options => ['a', 'b']},
  }
);


subtest 'Test deep clone' => sub {

  my $t = BASE_DATE();
  cmp_deeply(
    $t,
    { data_type                 => 'date',
      is_nullable               => 1,
      datetime_undef_if_invalid => 1,
      extra                     => {formatter => ignore()},
    },
    'Baseline BASE_DATE type'
  );

  $t = OTHER_DATE('extra.label' => 'y');
  cmp_deeply(
    $t,
    { data_type                 => 'date',
      is_nullable               => 1,
      datetime_undef_if_invalid => 1,
      extra                     => {
        formatter => ignore(),
        label     => 'y',
      },
    },
    "Expand OTHER_DATE a bit $t->{extra}"
  );

  $t = BASE_DATE();
  cmp_deeply(
    $t,
    { data_type                 => 'date',
      is_nullable               => 1,
      datetime_undef_if_invalid => 1,
      extra                     => {formatter => ignore()},
    },
    "Basic BASE_DATE type still the same $t->{extra}"
  );
};


done_testing();
