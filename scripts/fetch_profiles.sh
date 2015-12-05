#!/bin/bash

function profile() {
	ticker=$1
	output=$2
	wget -O $output "http://finance.yahoo.com/q/pr?s=$1+Profile"
}


export -f profile

output_dir=$1
mkdir -p $output_dir

xargs -i bash -c "profile {} $output_dir/profile_{}.csv"
