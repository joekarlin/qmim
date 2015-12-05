CREATE TABLE prices_raw (
	ticker VARCHAR(255) NOT NULL,
	date DATE NOT NULL,
	open DECIMAL(12,6) NOT NULL,
	high DECIMAL(12,6) NOT NULL,
	low DECIMAL(12,6) NOT NULL,
	close DECIMAL(12,6) NOT NULL,
	volume INT NOT NULL,
	adjusted_close DECIMAL(12,6) NOT NULL);

LOAD DATA LOCAL INFILE 'data/prices.csv'
INTO TABLE prices_raw FIELDS TERMINATED BY ';' LINES TERMINATED BY '\n';

INSERT INTO stock_prices
SELECT
	s.id,
	p.date,
	p.open,
	p.high,
	p.low,
	p.close,
	p.volume,
	p.adjusted_close
FROM prices_raw AS p
INNER JOIN stocks AS s ON p.ticker = s.ticker;
