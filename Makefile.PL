#!/usr/local/ls6/perl/bin/perl
#                              -*- Mode: Perl -*- 
# Makefile.PL -- 
# ITIID           : $ITI$ $Header $__Header$
# Author          : Ulrich Pfeifer
# Created On      : Thu Nov 23 20:04:51 1995
# Last Modified By: Ulrich Pfeifer
# Last Modified On: Mon Mar 25 22:05:22 1996
# Language        : Perl
# Update Count    : 20
# Status          : Unknown, Use with caution!
# 
# (C) Copyright 1995, Universität Dortmund, all rights reserved.
# 
# $Locker: pfeifer $
# $Log: Makefile.PL,v $
# Revision 1.0.1.4  1996/03/25 21:21:19  pfeifer
# patch6: New version numbering and handling. XSPROTOARG added.
#
# Revision 1.0.1.3  1995/11/24  10:25:45  pfeifer
# patch4: Support for Test:Harness.
#
# 
# To run the test, we need a mathlink connection. One way is to spawn
# a external process. Set the name of the program to start in the next
# line if you want it this way.

$MATHPROGRAM = 'math';

# The other way is to connect a remote server over TCP. You must start
# a server on the remote host befor running the tests. Use e.g.
#
# math -linkmode listen -linkprotocol TCP -linkname 3000 -mathlink
#
# Set the hostname and the port number in the next lines

$MATHHOST = 'schroeder';
$MATHPORT = 3000;

# if host and port are specified, the TCP version is used Note that
# the lines are not used when you run 'perl Makefile.PL'.  This file
# is read by the test scripts and the lines are evaluated - so do not
# write rash in this lines - bad trick - know that ;-)

if (($MATHHOST eq 'schroeder') && (`hostname` !~ /buster|schroeder/)) {
    die "Hey!. Edit Makefile.PL first!!!\n";
}

$MATHLIBDIR = '/usr/local/ls6/mathematica/Bin/MathLink';
$MATHINCDIR = '/usr/local/ls6/mathematica/Source/Includes';


die "MATHLIBDIR $MATHLIBDIR: $!\n" unless -d $MATHLIBDIR;
die "MATHINCDIR $MATHINCDIR: $!\n" unless -d $MATHINCDIR;

use ExtUtils::MakeMaker;
my $version = &get_version;
&rewrite('ematica.pm', $version);


# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    'NAME'	 => 'Math::ematica',
    'VERSION'	 => &get_version,
    'XSPROTOARG' => '-noprototypes', 
    'LIBS'	 => ["-L$MATHLIBDIR -lML"],
    'dist'       => { SUFFIX => 'gz', COMPRESS => 'gzip -f' },
    'clean' 	 => {'FILES' => '*~'},
    'DEFINE'	 => '',
    'INC'	 => "-I$MATHINCDIR",
);

sub get_version
{
    my ($version, $revision) = (5.0, 0);
    
    open(PATCH, "./patchlevel.h") || die "Could not open patchlevel.h: $!";
    while (<PATCH>) {
        if (/VERSION ([\d.]+)/) {
            $version = $1;
        }
        if (/PATCHLEVEL (\d+)/) {
            $revision = $1;
        }
    }
    sprintf("%5.3f", $version + $revision/1000);
}

sub rewrite {
    my ($file, $version) = @_;
    rename $file, $file.'.bak' or die "Could not rename $file: $!";
    open(IN, $file.'.bak') || die "Could not open $file.bak: $!";
    open(OUT, ">$file") || die "Could not open $file: $!";
    while (<IN>) {
        if (/^\$Math::ematica::VERSION = /) {
            print OUT "\$Math::ematica::VERSION = \$Math::ematica::VERSION = $version;\n";
        } else {
            print OUT;
        }
    }
    close(IN);
    close(OUT);
}

