CREATE DATABASE  IF NOT EXISTS `carrers` DEFAULT CHARSET latin1 ENGINE = INNODB;
USE `carrers`;

DROP TABLE IF EXISTS `industries`;
CREATE TABLE `industries` (
	code VARCHAR(10) NOT NULL,
	name VARCHAR(80) NOT NULL,
	language VARCHAR(80)
);


CREATE TABLE `salary` (	
  	type ENUM('hourly', 'daily', 'weekly', 'monthly', 'yearly') NOT NULL,
	min DECIMAL(13,4),
	max DECIMAL(13,4), 
	currency VARCHAR(10),
	PRIMARY KEY(rate_type, min, max, currency)
);

CREATE TABLE `location`(
	country VARCHAR(30) NOT NULL,
	city VARCHAR(50) NOT NULL, 
	state VARCHAR(50) DEFAULT NULL, 
	longitude DECIMAL(18,14) DEFAULT NULL,
	latitude DECIMAL(18,14) DEFAULT NULL,
	friendly_name VARCHAR(100) DEFAULT NULL, 
	PRIMARY_KEY(country, city, longitude, latitude)
)


CREATE TABLE `recruiter`(	
	name VARCHAR(50),
	did VARCHAR(20),
	details_url VARCHAR(200),
	logo_url VARCHAR(200),
	PRIMARY_KEY(name),
)
