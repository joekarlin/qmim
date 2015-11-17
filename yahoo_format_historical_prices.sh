#!/bin/bash

function format_historical_prices {
	file=$1
	ticker=`basename $file | pcregrep -o1 '([A-Z.]+).csv'`
	sed "s/^/$ticker,/g" $file | tail +2 | sort -t, -k1
}

export -f format_historical_prices

output=$1
rm $output

xargs -i bash -c 'format_historical_prices {}' >> $output
