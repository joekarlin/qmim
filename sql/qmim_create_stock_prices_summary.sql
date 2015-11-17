DROP TABLE IF EXISTS qmim.stock_prices_summary;

CREATE TABLE qmim.stock_prices_summary (
	stock_id INT NOT NULL,
	start_date DATE NOT NULL,
	end_date DATE NOT NULL,
	FOREIGN KEY (stock_id) REFERENCES qmim.stocks(id));

INSERT INTO qmim.stock_prices_summary
SELECT
	stock_id,
	MIN(date),
	MAX(date)
FROM qmim.stock_prices
GROUP BY stock_id;
