How to use
============

Use this to store scripts that convert the raw data to any other (cleaner) format (sql, csv, json, etc).

Guideline:

* Read the entire raw directory.
* Convert to another format.
	* NB: Try to use data format standards.
* Write to stdout, and use pipe to choose destination.