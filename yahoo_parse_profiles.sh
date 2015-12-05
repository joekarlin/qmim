#!/bin/bash

function parse_profile() {
	file=$1
	
	ticker=`basename $file | pcregrep -o1 '([A-Z.]+).html'`
	
	company=`pcregrep -o1 '<div class="yfi_rt_quote_summary" id="yfi_rt_quote_summary"><div class="hd"><div class="title"><h2>([A-Za-z0-9.,&!\s\;-]+)\s\(' $file`
	if [ -z "$company" ]; then return; fi
	
	exchange=`pcregrep -o1 '<span class="rtq_exch"><span class="rtq_dash">-</span>([A-Za-z0-9.,&!\s\;-]+[A-Za-z0-9.,&!\;-]+)\s*?</span>' $file`
	sector=`pcregrep -o1 'Sector:</td><td class=".*?"><a href=".*?">(.*?)</a>' $file`
	industry=`pcregrep -o1 'Industry:</td><td class=".*?"><a href=".*?">(.*?)</a>' $file`
	
	echo "$company;$ticker;$exchange;$sector;$industry" | sed 's/\&amp;/\&/g'
}

export -f parse_profile


output=$1
# rm $output

xargs -i bash -c "parse_profile {}" | tee $output
