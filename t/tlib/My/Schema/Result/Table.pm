package My::Schema::Result::Table;

use strict;
use warnings;
use base 'DBIx::Class';

use My::Schema::DataDictionary qw( PK NAME );

__PACKAGE__->load_components('+DBICx::DataDictionary::Expand', 'Core');
__PACKAGE__->table('table');

__PACKAGE__->add_columns(
  table_id => {data_type => PK},

  name => {
    data_type   => NAME,
    is_nullable => 1,
  },
  
  birth_month => {
    data_type => 'byte',
  },
  
  birth_year => {
    data_type => 'short',
  },
  
  never_null => {
    is_nullable => 0,
  },
  
  qw( a b c d e ),
);

__PACKAGE__->set_primary_key('table_id');

1;
