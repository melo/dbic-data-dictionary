package DBICx::DataDictionary;

use strict;
use warnings;
use parent 'Exporter';

@DBICx::DataDictionary::EXPORT = qw( add_type );

sub import {
  {
    no strict 'refs';
    unshift @{caller().'::ISA'}, 'Exporter';
  }

  goto \&Exporter::import;
}

sub add_type {
  my ($name, $spec) = @_;
  my $ns          = caller();
  my $full_name   = join('::', $ns, $name);
  my $export_ok   = join('::', $ns, 'EXPORT_OK');
  my $export_tags = join('::', $ns, 'EXPORT_TAGS');

  no strict 'refs';
  *{$full_name} = sub { +{ %$spec, @_ } };
  push @{$export_ok}, $name;
  ${$export_tags}{all} ||= \@{$export_ok};

  return;
}

1;

__END__

=encoding utf8

=head1 NAME

DBICx::DataDictionary - Define a data dictionary for your schema


=head1 SYNOPSIS

  ## asdasdassaddasd


=head1 DESCRIPTION

asdasdasd

=cut
