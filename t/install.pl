#!/usr/local/bin/perl 
#                              -*- Mode: Perl -*- 
# $Basename: install.pl $
# $Revision: 1.4 $
# Author          : Ulrich Pfeifer
# Created On      : Sun Jan 25 18:34:23 1998
# Last Modified By: Ulrich Pfeifer
# Last Modified On: Mon Feb 16 22:10:53 1998
# Language        : CPerl
# Update Count    : 53
# Status          : Unknown, Use with caution!
# 
# (C) Copyright 1998, Ulrich Pfeifer, all rights reserved.
# 
# 
use lib qw(blib/lib blib/arch);

use Math::ematica qw(:PACKET :TYPE :FUNC);

my $ml = new Math::ematica;
my $test;

sub addtwo {
  print STDERR "\nok ", ++$test, "\n";
  $_[0]+$_[1];
}

$ml->register('AddTwo',
              sub { print STDERR "\nok ", ++$test, "\n"; $_[0]+$_[1]},
              'Integer', 'Integer');
$ml->register('Add2', \&addtwo, 'Integer', 'Integer');
$ml->main;


