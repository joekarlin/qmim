#!/usr/bin/perl

use strict;
use warnings;


main();


sub main
{
	my $dates = {};
	my $tickers = {};
	
	while (my $line = <STDIN>) {
		chomp($line);
		my @line = split(',', $line);
		my $date = $line[0];
		my $ticker = $line[1];
		my $close = $line[2];
		
		$dates->{$date}->{$ticker} = $close;
		$tickers->{$ticker} = 1;
	}
	
	my @dates = sort(keys(%$dates));
	my @tickers = sort(keys(%$tickers));
	
	print 'date';
	
	for (my $t = 0; $t < scalar @tickers; ++$t) {
		print ',' . $tickers[$t];
	}
	
	print "\n";
	
	for (my $d = 0; $d < scalar @dates; ++$d) {
		my $date = $dates[$d];
		print $date;
		for (my $t = 0; $t < scalar @tickers; ++$t) {
			my $ticker = $tickers[$t];
			
			if (exists $dates->{$date}->{$ticker}) {
				my $close = $dates->{$date}->{$ticker};
				print ',' . $close;
			}
			else {
				# print STDERR "missing $date,$ticker\n";
				print ',NA';
			}
		}
		
		print "\n";
	}
}
