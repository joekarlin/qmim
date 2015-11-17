#!/usr/bin/perl

use strict;
use warnings;

# my $file = $ARGV[0];
# open (my $fh, $file) or die "open failed: $!";

while (my $line = <STDIN>) {
	my @line = split(';', $line);
	my $ticker = $line[0];
	
	for (my $i = 0; $i < 52; ++$i) {
		my $year = 2015 - $i;
		my $index = $i + 2;
		
		if ($line[$index] eq 'X') {
			print "$ticker;^GSPC;$year\n";
		}
	}
}
