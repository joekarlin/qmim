#!/bin/bash

function historical_prices() {
	ticker=$1
	output=$2
	wget -O $output "http://real-chart.finance.yahoo.com/table.csv?s=$ticker&a=02&b=4&c=1957&d=11&e=15&f=2015&g=d&ignore=.csv"
}

export -f historical_prices

output_dir=$1
mkdir -p $output_dir

xargs -i bash -c "historical_prices {} $output_dir/historical_prices_{}.csv"
