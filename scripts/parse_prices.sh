#!/bin/bash

function parse_prices {
	file=$1
	ticker=`basename $file | pcregrep -o1 '([A-Z.]+).csv'`
	tail +2 $file | sed "s/^/$ticker;/g" | tr , \; | sort -t\; -k1
}

export -f parse_prices
xargs -i bash -c 'parse_prices {}'
