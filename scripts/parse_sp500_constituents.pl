#!/usr/bin/perl

use strict;
use warnings;


while (my $line = <STDIN>) {
	chomp($line);
	my @line = split(';', $line);
	my $ticker = $line[0];
	
	for (my $i = 0; $i < 53; ++$i) {
		my $year = 2015 - $i;
		my $index = $i + 2;
		
		if ($index < scalar @line && $line[$index] eq 'X') {
			print "$ticker;$year\n";
		}
	}
}
