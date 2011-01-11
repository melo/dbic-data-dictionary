package My::Schema::DataDictionary;

use strict;
use warnings;
use DBICx::DataDictionary;

add_type PK => {
  data_type         => 'integer',
  is_nullable       => 0,
  is_auto_increment => 1,
};

add_type NAME => {
  data_type   => 'varchar',
  is_nullable => 0,
  size        => 100,
};

add_type SHORT_NAME => NAME(size => 40);

add_type VISIBILITY => {
  data_type => 'varchar',
  size      => 32,
  options   => [qw( ab cd )],
};

add_type XPTO => {
  data_type => 'varchar',
  size      => 20,
  default   => sub {'xpto is here'},
};

add_type BASE_DATE => {
  data_type                 => 'date',
  is_nullable               => 1,
  datetime_undef_if_invalid => 1,
  extra                     => {
    formatter => sub { }
  },
};

add_type OTHER_DATE => BASE_DATE();

1;
