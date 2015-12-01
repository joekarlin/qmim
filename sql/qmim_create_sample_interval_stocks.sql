DROP TABLE IF EXISTS qmim.sample_interval_stocks;

CREATE TABLE IF NOT EXISTS qmim.sample_interval_stocks (
	sample_interval_id INT NOT NULL,
	stock_id INT NOT NULL,
	FOREIGN KEY (sample_interval_id) REFERENCES qmim.sample_intervals (id),
	FOREIGN KEY (stock_id) REFERENCES qmim.stocks (id));

INSERT INTO qmim.sample_interval_stocks
SELECT i.id, s.stock_id
FROM qmim.sample_intervals AS i
INNER JOIN qmim.sample_stocks AS s ON
	FIND_IN_SET(YEAR(i.start), s.sp500_years) > 0
	AND FIND_IN_SET(YEAR(i.end), s.sp500_years) > 0
