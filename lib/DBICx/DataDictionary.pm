package DBICx::DataDictionary;

use strict;
use warnings;
use parent 'Exporter';

@DBICx::DataDictionary::EXPORT = qw( add_type );
@DBICx::DataDictionary::EXPORT_OK = qw( fetch_type );

my %_type_database;

sub import {
  my $caller = caller();

  {
    no strict 'refs';
    unshift @{join('::', $caller, 'ISA')}, 'Exporter';
  }

  goto \&Exporter::import;
}

sub add_type {
  my ($name, $spec) = @_;
  my $ns          = caller();
  my $full_name   = join('::', $ns, $name);
  my $export_ok   = join('::', $ns, 'EXPORT_OK');
  my $export_tags = join('::', $ns, 'EXPORT_TAGS');

  $_type_database{$full_name} = $spec;

  no strict 'refs';
  *{$full_name} = sub { return $full_name };
  push @{$export_ok}, $name;
  ${$export_tags}{all} ||= \@{$export_ok};

  return;
}

sub fetch_type {
  my ($name) = @_;
  
  return unless exists $_type_database{$name};
  return $_type_database{$name};
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
