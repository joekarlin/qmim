#!/usr/bin/perl

use strict;
use warnings;

use DBI;


main();


sub main
{
	my $output_dir = 'data/sample_stock_prices';
	mkdir($output_dir); # or die("mkdir() failed: $!");
	
	my $dbh = DBI->connect(
		'DBI:mysql:database=qmim;host=localhost', 'qmim', 'password', {'RaiseError' => 1});
	
	my $query = <<'EOF';
SELECT p.date, s.ticker, p.close
FROM sample_interval_stocks AS ss
INNER JOIN stocks AS s ON s.id = ss.stock_id
INNER JOIN sample_intervals AS i ON i.id = ss.sample_interval_id
INNER JOIN stock_prices AS p ON p.stock_id = ss.stock_id
WHERE ss.sample_interval_id = ?
	AND p.date >= i.start AND p.date <= i.end
EOF
	
	my $sth = $dbh->prepare($query);
	
	for (my $i = 1; $i <= 178; ++$i) {
		$sth->execute($i);
		
		my $dates = {};
		my $tickers = {};
		
		while (my $ref = $sth->fetchrow_arrayref()) {
			my $date = $ref->[0];
			my $ticker = $ref->[1];
			my $close = $ref->[2];
			
			if (exists $dates->{$date}) {
				$dates->{$date}->{$ticker} = $close;
			}
			else {
				$dates->{$date} = {$ticker => $close};
			}
			
			$tickers->{$ticker} = 1;
		}
		
		my @dates = sort(keys(%$dates));
		my @tickers = sort(keys(%$tickers));
		
		my $start = $dates[0];
		my $end = $dates[scalar @dates - 1];
		
		open(my $fh, '>', "$output_dir/stock_prices_$start\_$end.csv")
			or die("open() failed: $!");
		
		print $fh 'date';
		
		for (my $t = 0; $t < scalar @tickers; ++$t) {
			print $fh ',' . $tickers[$t];
		}
		
		print $fh "\n";
		
		for (my $d = 0; $d < scalar @dates; ++$d) {
			my $date = $dates[$d];
			print $fh $date;
			for (my $t = 0; $t < scalar @tickers; ++$t) {
				my $ticker = $tickers[$t];
				
				if (exists $dates->{$date}->{$ticker}) {
					my $close = $dates->{$date}->{$ticker};
					print $fh ',' . $close;
				}
				else {
					print STDERR "missing $date,$ticker\n";
					print $fh ',NA';
				}
			}
			
			print $fh "\n";
		}
		
		close($fh);
	}
}
