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

# echo 'SELECT ticker, sp500_years FROM sample_stocks ORDER BY ticker ASC' | mysql -uroot -p'(g37704d' qmim | tr '\t' ';' > data/sample_stocks.csv

# echo 'SELECT start, end FROM sample_intervals ORDER BY start ASC' | mysql -uroot -p'(g37704d' qmim | tr '\t' ',' | tail +2 > data/sample_intervals.csv

# echo 'SELECT sample_interval_id, COUNT(stock_id) FROM sample_interval_stocks GROUP BY sample_interval_id ORDER BY sample_interval_id ASC' | mysql -uroot -p'(g37704d' qmim | tr '\t' ',' | tail +2

# echo 'SELECT e.name FROM stock_prices AS p INNER JOIN stocks AS s ON s.id = p.stock_id INNER JOIN exchanges AS e ON e.id = s.exchange_id WHERE p.date = "2000-09-04" GROUP BY e.id' | mysql -uroot -p'(g37704d' qmim

# echo 'SELECT s.id, s.ticker FROM stock_prices AS p INNER JOIN stocks AS s ON s.id = p.stock_id WHERE p.date = "2000-09-04"' | mysql -uroot -p'(g37704d' qmim

# echo 'SELECT COUNT(s.ticker), s.ticker, e.name, c.name FROM stocks AS s INNER JOIN exchanges AS e ON e.id = s.exchange_id INNER JOIN companies AS c ON c.id = s.company_id GROUP BY s.ticker HAVING COUNT(s.ticker) > 1' | mysql -uroot -p'(g37704d' qmim
