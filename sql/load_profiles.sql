DROP TABLE IF EXISTS profiles_raw;

CREATE TABLE profiles_raw (
	company_name VARCHAR(255) NOT NULL,
	ticker VARCHAR(255) NOT NULL,
	exchange_name VARCHAR(255),
	sector_name VARCHAR(255),
	industry_name VARCHAR(255) NOT NULL);

LOAD DATA LOCAL INFILE 'data/profiles.csv'
INTO TABLE profiles_raw FIELDS TERMINATED BY ';' LINES TERMINATED BY '\n' (
	company_name,
	ticker,
	exchange_name,
	sector_name,
	industry_name);

INSERT INTO exchanges (name)
SELECT exchange_name FROM profiles_raw GROUP BY exchange_name ORDER BY exchange_name ASC;

INSERT INTO sectors (name)
SELECT sector_name FROM profiles_raw WHERE sector_name != '' GROUP BY sector_name ORDER BY sector_name ASC;

INSERT INTO industries (name)
SELECT industry_name FROM profiles_raw WHERE industry_name != '' GROUP BY industry_name ORDER BY industry_name ASC;

INSERT IGNORE INTO companies (name, sector_id, industry_id)
SELECT p.company_name, s.id, i.id
FROM profiles_raw AS p
LEFT JOIN sectors AS s ON p.sector_name = s.name
LEFT JOIN industries AS i ON p.industry_name = i.name;

INSERT INTO stocks (company_id, exchange_id, ticker)
SELECT c.id, e.id, p.ticker
FROM profiles_raw AS p
INNER JOIN companies AS c ON p.company_name = c.name
LEFT JOIN exchanges AS e ON p.exchange_name = e.name;
