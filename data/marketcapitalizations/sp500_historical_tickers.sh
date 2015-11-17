#!/bin/bash

constituents_by_year=$1

tail +3 $constituents_by_year \
	| awk -v OFS=\; -F\; '{print $1}' \
	| pcregrep -o1 '^([A-Z.]+)' \
	| sort | uniq
