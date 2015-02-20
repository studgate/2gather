CREATE DATABASE  IF NOT EXISTS `carrers` DEFAULT CHARSET latin1 ENGINE = INNODB;
USE `carrers`;

DROP TABLE IF EXISTS `industries`;
CREATE TABLE `industries` (
	code VARCHAR(10) NOT NULL,
	name VARCHAR(80) NOT NULL,
	language VARCHAR(80)
);

DROP TABLE IF EXISTS `salary`;
CREATE TABLE `salary` (
	id INT NOT NULL AUTO_INCREMENT,	
  	type ENUM('hourly', 'daily', 'weekly', 'monthly', 'yearly') NOT NULL,
	min DECIMAL(13,4),
	max DECIMAL(13,4), 
	currency VARCHAR(10),
	PRIMARY KEY(rate_type, min, max, currency)
);

DROP TABLE IF EXISTS `location`;
CREATE TABLE `location`(
	id INT NOT NULL AUTO_INCREMENT,
	country VARCHAR(30) NOT NULL,
	city VARCHAR(50) NOT NULL, 
	state VARCHAR(50) DEFAULT NULL, 
	longitude DECIMAL(18,14) DEFAULT NULL,
	latitude DECIMAL(18,14) DEFAULT NULL,
	friendly_name VARCHAR(100) DEFAULT NULL, 
	PRIMARY_KEY(country, city, longitude, latitude)
)

DROP TABLE IF EXISTS `recruiter`;
CREATE TABLE `recruiter`(	
	name VARCHAR(50),
	did VARCHAR(20),
	details_url VARCHAR(200),
	logo_url VARCHAR(200),
	PRIMARY_KEY(name),
)

DROP TABLE IF EXISTS `job_offer`;
CREATE TABLE `job_offer`(
	did VARCHAR(20) PRIMARY KEY,
	title VARCHAR(50) NOT NULL,
	description VARCHAR(2000),
	type enum('Permanent','Part-Time','Full-Time') DEFAULT `Full-Time`, /*devia estar mais completo, contract /1M/3M, etc*/
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
  	
  	FOREIGN KEY (recruiter) REFERENCES recruiter(name),
  	FOREIGN KEY (industry) REFERENCES industries(code),
  	FOREIGN KEY (location) REFERENCES location(id),
  	FOREIGN KEY (salary) REFERENCES salary(id),
)

DROP TABLE IF EXISTS `skills_by_job_offer`;
CREATE TABLE `skills_by_job_offer`(
	job_did VARCHAR(20) NOT NULL,
	skill VARCHAR(50) NOT NULL,
	
	PRIMARY_KEY(job_did, skill),
	
	FOREIGN KEY (job) REFERENCES job_offer(did),
  	FOREIGN KEY (skill) REFERENCES skills(name),	
)

DROP TABLE IF EXISTS `skills`;
CREATE TABLE `skills` (
  name VARCHAR(50) PRIMARY_KEY  
)

DROP TABLE IF EXISTS `skills_synonyms`;
CREATE TABLE `skills_synonyms`(
	skill_a VARCHAR(50),
	skill_b VARCHAR(50),
	
	FOREIGN KEY (skill_a) REFERENCES skills(name),
	FOREIGN KEY (skill_b) REFERENCES skills(name),
	
	PRIMARY_KEY (skill_a, skill_b),
)
