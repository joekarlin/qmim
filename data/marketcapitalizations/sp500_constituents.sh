#!/bin/bash

tail +3 sp500_constituents_by_year.csv | ./sp500_constituents.pl | sort | grep -E -v '^[A-Z]+ \('
