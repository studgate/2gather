DROP DATABASE IF EXISTS `carrers`;
CREATE DATABASE  IF NOT EXISTS `carrers`;
USE `carrers`;


DROP TABLE IF EXISTS `tbl_industries`;
CREATE TABLE `tbl_industries` (
	code VARCHAR(10),
	name VARCHAR(80) NOT NULL,
	language VARCHAR(80),
	PRIMARY KEY(code)
);

DROP TABLE IF EXISTS `tbl_salary`;
CREATE TABLE `tbl_salary` (
	id INT NOT NULL AUTO_INCREMENT,	
  	rate_type ENUM('hourly', 'daily', 'weekly', 'monthly', 'yearly') NOT NULL,
	min_value DECIMAL(13,4),
	max_value DECIMAL(13,4), 
	currency VARCHAR(10),
	PRIMARY KEY(id, min_value, max_value, currency)
);

DROP TABLE IF EXISTS `tbl_location`;
CREATE TABLE `tbl_location`(
	id INT NOT NULL AUTO_INCREMENT,
	country VARCHAR(30) NOT NULL,
	city VARCHAR(50) NOT NULL, 
	state VARCHAR(50) DEFAULT NULL, 
	longitude DECIMAL(18,14) DEFAULT NULL,
	latitude DECIMAL(18,14) DEFAULT NULL,
	friendly_name VARCHAR(100) DEFAULT NULL, 
	PRIMARY KEY(id,country, city, longitude, latitude)
);

DROP TABLE IF EXISTS `tbl_recruiter`;
CREATE TABLE `tbl_recruiter`(	
	name VARCHAR(50),
	did VARCHAR(20),
	details_url VARCHAR(200),
	logo_url VARCHAR(200),
	PRIMARY KEY(name)
);

DROP TABLE IF EXISTS `tbl_job_offer`;
CREATE TABLE `tbl_job_offer`(
	did VARCHAR(20) PRIMARY KEY,
	title VARCHAR(50) NOT NULL,
	description VARCHAR(2000),
	job_type enum('Permanent','Part-Time','Full-Time') DEFAULT 'Full-Time', /*devia estar mais completo, contract /1M/3M, etc*/
	experience VARCHAR(50),
	begin_date DATE,
	end_date DATE,
	posted_date DATE,
	travel_required BOOLEAN DEFAULT FALSE,
  	relocation_covered BOOLEAN DEFAULT FALSE,
  	recruiter VARCHAR(50),
  	industry VARCHAR(10),
  	location INT NOT NULL,
  	salary INT NOT NULL,
  	
  	FOREIGN KEY (recruiter) REFERENCES tbl_recruiter(name),
  	FOREIGN KEY (industry) REFERENCES tbl_industries(code),
  	FOREIGN KEY (location) REFERENCES tbl_location(id),
  	FOREIGN KEY (salary) REFERENCES tbl_salary(id)
);

DROP TABLE IF EXISTS `tbl_skills`;
CREATE TABLE `tbl_skills` (
	name VARCHAR(50) PRIMARY KEY  
);

DROP TABLE IF EXISTS `tbl_skills_by_job_offer`;
CREATE TABLE `tbl_skills_by_job_offer`(
	job_did VARCHAR(20) NOT NULL,
	skill VARCHAR(50) NOT NULL,
	
	PRIMARY KEY(job_did, skill),
	
	FOREIGN KEY (job_did) REFERENCES tbl_job_offer(did),
  	FOREIGN KEY (skill) REFERENCES tbl_skills(name)
);


DROP TABLE IF EXISTS `tbl_skills_synonyms`;
CREATE TABLE `tbl_skills_synonyms`(
	skill_a VARCHAR(50),
	skill_b VARCHAR(50),
	
	FOREIGN KEY (skill_a) REFERENCES tbl_skills(name),
	FOREIGN KEY (skill_b) REFERENCES tbl_skills(name),
	
	PRIMARY KEY (skill_a, skill_b)
);

DROP TABLE IF EXISTS `tbl_requirements`;
CREATE TABLE `tbl_requirements` (
	Code varchar(10) NOT NULL,
  	Description varchar(70) DEFAULT NULL,
	
	PRIMARY KEY(Code)
);

DROP TABLE IF EXISTS `tbl_job_requirements`;
CREATE TABLE `tbl_job_requirements` (
	did VARCHAR(20) NOT NULL,
  	Code varchar(10) NOT NULL,

	FOREIGN KEY (did) REFERENCES tbl_job_offer(did),
	FOREIGN KEY (Code) REFERENCES tbl_requirements(Code),

	PRIMARY KEY(did, Code)
);


