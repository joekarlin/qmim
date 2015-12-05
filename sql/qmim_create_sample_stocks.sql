DROP TABLE IF EXISTS qmim.sample_stocks;

CREATE TABLE qmim.sample_stocks (
	stock_id INT NOT NULL,
	ticker VARCHAR(255) NOT NULL,
	sp500_years VARCHAR(255) NOT NULL,
	FOREIGN KEY (stock_id) REFERENCES qmim.stocks (id),
	FOREIGN KEY (ticker) REFERENCES qmim.stocks (ticker));

INSERT INTO qmim.sample_stocks
SELECT c.stock_id, s.ticker, GROUP_CONCAT(c.year ORDER BY c.year ASC SEPARATOR ',')
FROM qmim.constituents AS c
INNER JOIN qmim.stocks AS s ON c.stock_id = s.id
WHERE c.index_id = (SELECT id FROM qmim.indexes WHERE ticker = '^GSPC')
	AND c.year >= 2000
GROUP BY c.stock_id
