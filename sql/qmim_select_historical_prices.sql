DROP TABLE qmim.sample_constituents;

CREATE TABLE qmim.sample_constituents (
	stock_id INT NOT NULL,
	ticker VARCHAR(255) NOT NULL,
	sector_name VARCHAR(255) NOT NULL,
	FOREIGN KEY (stock_id) REFERENCES qmim.stocks (id));
	-- FOREIGN KEY ticker REFERENCES qmim.stocks (ticker),
	-- FOREIGN KEY sector_name REFERENCES qmim.sectors (name)

INSERT INTO qmim.sample_constituents
SELECT c.stock_id, s.ticker, se.name
FROM qmim.constituents AS c
INNER JOIN qmim.stocks AS s ON c.stock_id = s.id
INNER JOIN qmim.companies AS co ON s.company_id = co.id
INNER JOIN qmim.sectors AS se ON co.sector_id = se.id
WHERE c.index_id = (SELECT id FROM qmim.indexes WHERE ticker = '^GSPC')
GROUP BY c.stock_id
HAVING MIN(c.year) <= 2010 AND MAX(c.year) >= 2000;
