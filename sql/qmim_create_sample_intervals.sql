DROP TABLE IF EXISTS qmim.sample_intervals;
CREATE TABLE IF NOT EXISTS qmim.sample_intervals (
	id INT AUTO_INCREMENT NOT NULL,
	start DATE NOT NULL,
	end DATE NOT NULL,
	PRIMARY KEY (id));


DELIMITER //
DROP PROCEDURE IF EXISTS qmim.create_sample_intervals //

CREATE PROCEDURE qmim.create_sample_intervals()
BEGIN

DECLARE start DATE DEFAULT '1999-12-01';
DECLARE end DATE;

REPEAT
	SET start = DATE_ADD(start, INTERVAL 1 MONTH);
	SET end = LAST_DAY(start + INTERVAL 1 YEAR);
	INSERT INTO qmim.sample_intervals (`start`, `end`) VALUES(start, end);
UNTIL start > '2014-09-01'
-- UNTIL start > '1999-12-01'
END REPEAT;

END //

CALL qmim.create_sample_intervals() //
DELIMITER ;
