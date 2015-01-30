use enroll;
LOAD DATA LOCAL INFILE './sql/recruiters.sql' INTO TABLE recruiter
FIELDS TERMINATED BY '\001'
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(`name`, `did`, `details_url`, `logo_url`);