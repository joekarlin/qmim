#!/bin/bash

constituents_by_year=$1

tail +3 $constituents_by_year \
	| awk -v OFS=\; -F\; '{print $1, $2}' \
	| sed -r 's/^([A-Z]+) .+;/\1;/g' \
	| sort -k1 -t\;| uniq
