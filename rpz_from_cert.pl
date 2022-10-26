#!/usr/local/bin/perl
#
# Create RPZ file from https://hole.cert.pl/domains/domains_hosts.txt 
# Version 0.1
# Copyright (c) 2022 mzary

use POSIX qw(strftime);
use LWP::Simple;
use strict;

my $RPZfile = '/usr/local/www/apache24/data/RPZ/hole.cert.pl.zone';
open (RPZ,'>',$RPZfile) or die $!;

my $CERTdata = get('http://hole.cert.pl/domains/domains_hosts.txt');
open (CERT,'<',\$CERTdata) or die $!;

my $datestring = strftime ("%Y-%m-%d %H:%M:%S %Z", localtime);

while (<CERT>) {
    chop;
    if($_ =~ /# Version:/){
	(undef, my $serial) = split(/: /,$_);
	print RPZ ('$TTL 60');
	print RPZ ("\n@ SOA rpz.hole.cert.pl. hostmaster.hole.cert.pl. ".$serial." 300 1800 604800 60\n NS localhost.\n");
	print RPZ (";\n; hole.cert.pl CERT.PL Response Policy Zones (RPZ)\n; Last updated: ".$datestring."\n");
	print RPZ (";\n; Terms of use https://cert.pl/ostrzezenia_phishing\n;\n");
    }
    if($_ !~ /^#/){
	(my $ip, my $domain) = split(/\s{1,}/,$_);
	print RPZ ($domain." A ".$ip."\n");
    }
}

close  CERT;
close  RPZ;
