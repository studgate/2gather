/**
 * Exports all the recruites info into SQL statements
 */

var xmlloader = require("../helpers/XMLLoader.js");
var mysqlHelper = require("../helpers/mysqlHelper.js")
var squel = require("squel");
squel.useFlavour('mysql');

var FIELD_SEP = '\u0001';

var dbName = "enroll";
var tableName = "recruiter";
var RecruiterFieldsEnum = {"Name": "Company", "Id": "CompanyDID", "Details": "CompanyDetailsURL", "Logo": "CompanyImageURL"};
var dbFieldsEnum = {"Name": "name", "Id": "did", "Details": "details_url", "Logo": "logo_url"};
var recruiters = [];


function extractRelevantFields(xml)
{	
	var rootNodeTag = "Results";

	var rootNode = xml.childNamed(rootNodeTag); 
	
	if (rootNode.children.length == 0)
	{
		return;
	}		
	rootNode.eachChild(function(node, index, data){	 /*each JobSearchResult */		
		var name = node.childNamed(RecruiterFieldsEnum.Name).val;	
		var id, details, logo;	
		if (recruiters.indexOf(name) < 0)
		{
			id = node.childNamed(RecruiterFieldsEnum.Id).val;
			details = node.childNamed(RecruiterFieldsEnum.Details).val;
			logo = node.childNamed(RecruiterFieldsEnum.Details).val;

			recruiters.push(name);
			name = mysqlHelper.mysql_escape_string(name);
			id = mysqlHelper.mysql_escape_string(id);			
			details = mysqlHelper.mysql_escape_string(details);			
			logo = mysqlHelper.mysql_escape_string(logo);			
			generateSQLStatement(name, id, details, logo);	
		}

	});	
}


function generateSQLStatement(name, id, details, logo)
{
	/*
	console.log((squel.insert()
			.into(tableName)
			.set(dbFieldsEnum.Name, name)
			.set(dbFieldsEnum.Id, id)
			.set(dbFieldsEnum.Details, details)
			.set(dbFieldsEnum.Logo, logo)
			.onDupUpdate(dbFieldsEnum.Name, name)).toString() + ';');
*/
	console.log(name + FIELD_SEP + id + FIELD_SEP + details + FIELD_SEP + logo);
}

console.log("use %s;", dbName);
xmlloader.getEach("./raw", function(err, doc){
	if (err)
	{	
		console.log("ERROR: " + err);
		throw "error";
	}	
	else{
		extractRelevantFields(doc);
		doc=undefined; //no longer required
		}
});