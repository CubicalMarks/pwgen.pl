#!/usr/bin/perl -w
#
# Simple password generator.
#
# Copyright (c) 2006 Marcus Libäck <marcus@terminal.se>
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
# 3. The name of the author may not be used to endorse or promote products
#    derived from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
# IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
# OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
# IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
# INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
# NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
# THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

use strict;
use Getopt::Std;

my $version = "1.0";
my %opts;
my $num = 1;
my $pwlen = 12;
my $special = 1;

getopts('l:n:sh', \%opts);

# Help.
if (exists $opts{'h'}) {
    help();
}

# Special characters...
unless (exists $opts{'s'}) {
    undef $special;
}

# Number of passwords to generate.
if (exists $opts{'n'}) {
    if ($opts{'n'} =~ m/^[0-9]*$/) {
        $num = $opts{'n'};
    } else {
        die "Invalid number of passwords to generate $opts{'n'}";
    }
}

# Password length.
if (exists $opts{'l'}) {
    if ($opts{'l'} =~ m/^[0-9]*$/) {
        $pwlen = $opts{'l'};
    } else {
        die "Invalid password length $opts{'l'}";
    }
}

for (my $i=0;$i<$num;++$i) {
    print pwgen($pwlen),"\n";
}
#print "Password(s) generated.\n";

# Password generation routine.
sub pwgen {
    my $pwlen = shift;
    my $password;
    my $_rand;

    my @chars = split (" ","a b c d e f g h i j k l m n o p q r s t u v w x y z 
                            A B C D E F G H I J K L M N O P Q R S T U V W X Y Z 
                            0 1 2 3 4 5 6 7 8 9 
                            - _ # % & / ( ) = ? + * ! @");

    srand;

    for (my $i=0;$i<$pwlen;++$i) {
        if (defined $special) {
            $_rand = int(rand 76);
        } else {
            $_rand = int(rand 62);
        }

        $password .= $chars[$_rand];
    }

    return $password;
}

# Help.
sub help {
    print "Version $version

Usage: $0 [options]

Options:
 -h     display this text.

 -l     password length, defaults to $pwlen.
 -n     number of passwords to generate, defaults to $num.
 -s     includes special characters.\n";

    exit;
}

