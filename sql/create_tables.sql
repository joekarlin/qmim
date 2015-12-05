CREATE TABLE IF NOT EXISTS exchanges (
	id INT AUTO_INCREMENT NOT NULL,
	name VARCHAR(255) NOT NULL,
	PRIMARY KEY (id),
	UNIQUE KEY (name));

CREATE TABLE IF NOT EXISTS sectors (
	id INT AUTO_INCREMENT NOT NULL,
	name VARCHAR(255) NOT NULL,
	PRIMARY KEY (id),
	UNIQUE KEY(name));

CREATE TABLE IF NOT EXISTS industries (
	id INT AUTO_INCREMENT NOT NULL,
	name VARCHAR(255) NOT NULL,
	PRIMARY KEY (id),
	UNIQUE KEY (name));

CREATE TABLE IF NOT EXISTS companies (
	id INT AUTO_INCREMENT NOT NULL,
	name VARCHAR(255) NOT NULL,
	sector_id INT,
	industry_id INT,
	PRIMARY KEY (id),
	UNIQUE KEY (name),
	FOREIGN KEY (sector_id) REFERENCES sectors (id),
	FOREIGN KEY (industry_id) REFERENCES industries (id));

CREATE TABLE IF NOT EXISTS stocks (
	id INT AUTO_INCREMENT NOT NULL,
	company_id INT NOT NULL,
	exchange_id INT NOT NULL,
	ticker VARCHAR(255) NOT NULL,
	PRIMARY KEY (id),
	FOREIGN KEY (company_id) REFERENCES companies (id),
	FOREIGN KEY (exchange_id) REFERENCES exchanges (id),
	KEY (ticker));

CREATE TABLE IF NOT EXISTS indexes (
	id INT AUTO_INCREMENT NOT NULL,
	name VARCHAR(255) NOT NULL,
	PRIMARY KEY (id),
	UNIQUE KEY (name));

CREATE TABLE IF NOT EXISTS constituents (
	stock_id INT NOT NULL,
	index_id INT NOT NULL,
	year YEAR NOT NULL,
	FOREIGN KEY (stock_id) REFERENCES stocks (id),
	FOREIGN KEY (index_id) REFERENCES indexes (id),
	KEY (year));

CREATE TABLE IF NOT EXISTS stock_prices (
	stock_id INT NOT NULL,
	date DATE NOT NULL,
	open DECIMAL(12,6) NOT NULL,
	high DECIMAL(12,6) NOT NULL,
	low DECIMAL(12,6) NOT NULL,
	close DECIMAL(12,6) NOT NULL,
	volume INT NOT NULL,
	adjusted_close DECIMAL(12,6) NOT NULL,
	FOREIGN KEY (stock_id) REFERENCES stocks (id));
