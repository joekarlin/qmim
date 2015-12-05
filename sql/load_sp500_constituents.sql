DROP TABLE IF EXISTS sp500_constituents_raw;

CREATE TABLE sp500_constituents_raw (
	ticker VARCHAR(255) NOT NULL,
	year YEAR NOT NULL);

LOAD DATA LOCAL INFILE 'data/sp500_constituents.csv'
INTO TABLE sp500_constituents_raw FIELDS TERMINATED BY ';' LINES TERMINATED BY '\n';

INSERT INTO indexes (name) VALUES ('S&P 500');

INSERT INTO constituents (stock_id, index_id, year)
SELECT s.id, (SELECT id FROM indexes WHERE name = 'S&P 500'), c.year
FROM sp500_constituents_raw AS c
INNER JOIN stocks AS s ON c.ticker = s.ticker
