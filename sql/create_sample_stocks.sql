DROP TABLE IF EXISTS sample_stocks;

CREATE TABLE sample_stocks (
	stock_id INT NOT NULL,
	ticker VARCHAR(255) NOT NULL,
	sp500_years VARCHAR(255) NOT NULL,
	FOREIGN KEY (stock_id) REFERENCES stocks (id),
	FOREIGN KEY (ticker) REFERENCES stocks (ticker));

INSERT INTO sample_stocks
SELECT c.stock_id, s.ticker, GROUP_CONCAT(c.year ORDER BY c.year ASC SEPARATOR ',')
FROM constituents AS c
INNER JOIN stocks AS s ON c.stock_id = s.id
WHERE c.index_id = (SELECT id FROM indexes WHERE name = 'S&P 500')
	AND c.year >= 2000 AND c.year <= 2015
GROUP BY c.stock_id
