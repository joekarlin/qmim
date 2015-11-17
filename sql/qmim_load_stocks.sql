DROP TABLE IF EXISTS qmim.companies_raw;

CREATE TABLE qmim.companies_raw (
	company_name VARCHAR(255) NOT NULL,
	ticker VARCHAR(255) NOT NULL,
	exchange_name VARCHAR(255),
	sector_name VARCHAR(255),
	industry_name VARCHAR(255) NOT NULL);

LOAD DATA LOCAL INFILE 'data/qmim/companies.csv'
INTO TABLE qmim.companies_raw FIELDS TERMINATED BY ';' LINES TERMINATED BY '\n' (
	company_name,
	ticker,
	exchange_name,
	sector_name,
	industry_name);

INSERT INTO qmim.exchanges (name)
SELECT exchange_name FROM qmim.companies_raw GROUP BY exchange_name ORDER BY exchange_name ASC;

INSERT INTO qmim.sectors (name)
SELECT sector_name FROM qmim.companies_raw WHERE sector_name != '' GROUP BY sector_name ORDER BY sector_name ASC;

INSERT INTO qmim.industries (name)
SELECT industry_name FROM qmim.companies_raw WHERE industry_name != '' GROUP BY industry_name ORDER BY industry_name ASC;

INSERT INTO qmim.companies (name, sector_id, industry_id)
SELECT c.company_name, s.id, i.id
FROM qmim.companies_raw AS c
LEFT JOIN qmim.sectors AS s ON c.sector_name = s.name
LEFT JOIN qmim.industries AS i ON c.industry_name = i.name;

INSERT INTO qmim.stocks (ticker, exchange_id, company_id)
SELECT s.ticker, e.id, c.id
FROM qmim.companies_raw AS s
LEFT JOIN qmim.exchanges AS e ON s.exchange_name = e.name
LEFT JOIN qmim.companies AS c ON s.company_name = c.name;
