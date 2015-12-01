CREATE DATABASE IF NOT EXISTS qmim;
-- CREATE USER 'qmim'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON qmim.* to 'qmim'@'localhost';

CREATE TABLE IF NOT EXISTS qmim.exchanges (
	id INT AUTO_INCREMENT NOT NULL,
	name VARCHAR(255) NOT NULL,
	PRIMARY KEY (id),
	UNIQUE KEY (name));

CREATE TABLE IF NOT EXISTS qmim.sectors (
	id INT AUTO_INCREMENT NOT NULL,
	name VARCHAR(255) NOT NULL,
	PRIMARY KEY (id),
	UNIQUE KEY(name));

CREATE TABLE IF NOT EXISTS qmim.industries (
	id INT AUTO_INCREMENT NOT NULL,
	name VARCHAR(255) NOT NULL,
	PRIMARY KEY (id),
	UNIQUE KEY (name));

CREATE TABLE IF NOT EXISTS qmim.companies (
	id INT AUTO_INCREMENT NOT NULL,
	name VARCHAR(255) NOT NULL,
	sector_id INT,
	industry_id INT,
	PRIMARY KEY (id),
	FOREIGN KEY (sector_id) REFERENCES qmim.sectors (id),
	FOREIGN KEY (industry_id) REFERENCES qmim.industries (id));

CREATE TABLE IF NOT EXISTS qmim.stocks (
	id INT AUTO_INCREMENT NOT NULL,
	ticker VARCHAR(255) NOT NULL,
	exchange_id INT NOT NULL,
	company_id INT NOT NULL,
	PRIMARY KEY (id),
	KEY (ticker),
	FOREIGN KEY (exchange_id) REFERENCES qmim.exchanges (id),
	FOREIGN KEY (company_id) REFERENCES qmim.companies (id));

CREATE TABLE IF NOT EXISTS qmim.stock_prices (
	stock_id INT NOT NULL,
	date DATE NOT NULL,
	open DECIMAL(12,6) NOT NULL,
	high DECIMAL(12,6) NOT NULL,
	low DECIMAL(12,6) NOT NULL,
	close DECIMAL(12,6) NOT NULL,
	volume INT NOT NULL,
	adjusted_close DECIMAL(12,6) NOT NULL,
	FOREIGN KEY (stock_id) REFERENCES qmim.stocks (id));

CREATE TABLE IF NOT EXISTS qmim.indexes (
	id INT AUTO_INCREMENT NOT NULL,
	ticker VARCHAR(255) NOT NULL,
	name VARCHAR(255) NOT NULL,
	PRIMARY KEY (id),
	UNIQUE KEY (ticker));

CREATE TABLE IF NOT EXISTS qmim.constituents (
	stock_id INT NOT NULL,
	index_id INT NOT NULL,
	year YEAR NOT NULL,
	FOREIGN KEY (stock_id) REFERENCES qmim.stocks (id),
	FOREIGN KEY (index_id) REFERENCES qmim.indexes (id),
	INDEX (year));
