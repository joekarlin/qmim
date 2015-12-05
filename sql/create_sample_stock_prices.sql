DROP TABLE IF EXISTS sample_stock_prices;

CREATE TABLE sample_stock_prices (
	date DATE NOT NULL,
	ticker VARCHAR(255) NOT NULL,
	open DECIMAL(12,6) NOT NULL);

INSERT INTO sample_stock_prices
SELECT  p.date, s.ticker, p.open
FROM sample_stocks AS s
INNER JOIN stock_prices AS p ON p.stock_id = s.stock_id
WHERE p.date >= '2000-01-01' AND p.date <= LAST_DAY('2015-10-31')
