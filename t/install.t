#!/usr/local/bin/perl 
#                              -*- Mode: Perl -*- 
# $Basename: install.t $
# $Revision: 1.1 $
# Author          : Ulrich Pfeifer
# Created On      : Sun Jan 25 18:34:23 1998
# Last Modified By: Ulrich Pfeifer
# Last Modified On: Mon Feb 16 22:14:13 1998
# Language        : CPerl
# Update Count    : 65
# Status          : Unknown, Use with caution!
# 
# (C) Copyright 1998, Ulrich Pfeifer, all rights reserved.
# 
#

BEGIN { $|= 1; print "1..2\n" };

open(MATH, "|math 2>&1") or die "Could not run 'math': $!\n";
while (<DATA>) {
  print MATH;
}
close MATH;
__DATA__
Install["./t/install.pl"]
AddTwo[2,3]
Add2[2,3]
Quit
