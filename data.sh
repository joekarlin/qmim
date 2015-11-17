#!/bin/bash

#cat data/marketcapitalizations/sp500_historical_tickers.csv \
#	| ./yahoo_historical_prices.sh data/yahoo/historical_prices

#cat data/marketcapitalizations/sp500_historical_tickers.csv \
#	| ./yahoo_profiles.sh data/yahoo/profiles

#ls data/yahoo/historical_prices/*csv \
#	| ./yahoo_format_historical_prices.sh data/qmim/prices.csv

# ls data/yahoo/profiles/*html \
#	| ./yahoo_parse_profiles.sh data/qmim/companies.csv

# echo 'SELECT sector_name, ticker FROM sample_stocks ORDER BY sector_name ASC, ticker ASC' | mysql -uroot -p'(g37704d' qmim | tr '\t' ',' > data/sample_stocks.csv

# echo 'SELECT ticker, date, open, close FROM sample_stock_prices ORDER BY ticker ASC, date ASC' | mysql -uroot -p'(g37704d' qmim | tr '\t' ',' > data/sample_stock_prices.csv
