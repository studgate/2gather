var fs = require('fs');
var squel = require("squel");
squel.useFlavour('mysql');
var mysqlHelper = require("../helpers/mysqlHelper.js")
var xmlloader = require("../helpers/XMLLoader.js");


var dbName = "enroll";
var tableName = "industries";

var fileOutputPath = "../raw/createIndustries.sql";

var myData = [];

function extractRelevantFields(doc)
{
	var countryCode = doc.childNamed("CountryCode").val;

	var rootNode = doc.childNamed("IndustryCodes");

	if (rootNode.children.length == 0)
	{
		return;
	}		
	var name, code, language;
	rootNode.eachChild(function(node, index, data){	 /*each IndustryCode */	
		code = node.childNamed("Code").val;
		name = node.childNamed("Name").val;
		language = node.childNamed("Name").attr["language"];
		//console.log(code, name, language);
		if (!data.hasOwnProperty(code))
		{
			myData.push([code, mysqlHelper.mysql_escape_string(name), language]);
		}

	});
}

function dumpToFile(str)
{
	fs.writeFile(fileOutputPath, str, function(err) {
    if(err) {
        console.log(err);
    } else {
        console.log("The file was saved to %s!", fileOutputPath);
    }
}); 
}

function dump2SQL()
{
	var industryCount = myData.length;
	var raw_sql = "";
	for (var i =0;i<industryCount;i++)
	{
		raw_sql += squel.insert()
			.into(tableName)
			.set("code", myData[i][0])
			.set("name", myData[i][1])
			.set("language", myData[i][2])
			.toString() + ';\n';				
	}
	dumpToFile(raw_sql);
}

xmlloader.getEach("../raw/industries", function(err, doc, done){
	if (err)
	{	
		console.log("ERROR: " + err);
		throw "error";
	}	
	else{
		if (!done){
			extractRelevantFields(doc);
			doc=undefined; //no longer required
			}
		else
			dump2SQL();

		}
});

