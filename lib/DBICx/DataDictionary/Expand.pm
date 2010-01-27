package DBICx::DataDictionary::Expand;

use strict;
use warnings;
use base 'DBIx::Class';

use DBICx::DataDictionary qw( fetch_type );


sub add_columns {
  my $class = shift;
  
  for my $spec (@_) {
    next unless ref($spec) eq 'HASH';
    next unless exists $spec->{data_type};
    next unless my $type = fetch_type($spec->{data_type});
    
    delete $spec->{data_type};
    $spec = __merge_hash($spec, $type);
  }

  return $class->next::method(@_);
}

sub __merge_hash {
  my ($user, $defaults) = @_;

  return {%$defaults, %$user};
}

1;
