DROP TABLE IF EXISTS qmim.sample_stock_prices;

CREATE TABLE qmim.sample_stock_prices (
	ticker VARCHAR(255) NOT NULL,
	date DATE NOT NULL,
	close DECIMAL(12,6) NOT NULL);

INSERT INTO qmim.sample_stock_prices
SELECT s.ticker, p.date, p.close
FROM qmim.sample_stocks AS s
LEFT JOIN qmim.stock_prices AS p ON p.stock_id = s.stock_id
WHERE p.date >= '2000-01-01' AND p.date <= LAST_DAY('2015-10-01')
ORDER BY s.ticker ASC, p.date ASC
