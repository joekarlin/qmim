DROP TABLE IF EXISTS qmim.constituents_raw;

CREATE TABLE qmim.constituents_raw (
	stock_ticker VARCHAR(255) NOT NULL,
	index_ticker VARCHAR(255) NOT NULL,
	year YEAR NOT NULL);

LOAD DATA LOCAL INFILE 'data/qmim/constituents.csv'
INTO TABLE qmim.constituents_raw FIELDS TERMINATED BY ';' LINES TERMINATED BY '\n' (
	stock_ticker,
	index_ticker,
	year);

INSERT INTO qmim.indexes (ticker, name)
SELECT index_ticker, 'S&P 500' FROM qmim.constituents_raw GROUP BY index_ticker; -- TODO

INSERT INTO qmim.constituents (stock_id, index_id, year)
SELECT s.id, i.id, c.year FROM qmim.constituents_raw AS c
INNER JOIN qmim.stocks AS s ON c.stock_ticker = s.ticker
INNER JOIN qmim.indexes AS i on c.index_ticker = i.ticker;
