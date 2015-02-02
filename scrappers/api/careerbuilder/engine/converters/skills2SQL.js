var fs = require('fs');
var squel = require("squel");
squel.useFlavour('mysql');
var mysqlHelper = require("../helpers/mysqlHelper.js")

var FIELD_SEP = '\u0001';

var dbName = "enroll";
var tableName = "skills";

var fileInputPath = "../raw/dids&skills.csv";
var fileOutputPath = "../raw/createskills.sql";

var fileContent;

fs.readFile(fileInputPath, {encoding: 'utf-8'}, function(err,data){
    if (!err){
    	fileContent = data;
    	parseFileContents();
    }    
});

function parseFileContents()
{
	var allSkills=[];
	var lines = fileContent.split('\n');
	var lineCount = lines.length;

	var skills, attr;
	for (var i=0;i<lineCount;i++)
	{
		skills = lines[i].split(FIELD_SEP)[1];
		if (skills ){
			attr = skills.split(',');

			for (var j = 0;j<attr.length;j++)
			{					
				attr[j] = attr[j].toUpperCase();
				attr[j] = mysqlHelper.mysql_escape_string(attr[j]);
				if (allSkills.indexOf(attr[j]) < 0 && attr[j])
				{
					allSkills.push(attr[j]);
					console.log("New skill found: %s",attr[j] );
				}
			}
		}
	}

	generateSQL(allSkills);
}

function generateSQL(allSkills)
{
	var skillCount = allSkills.length;
	var raw_sql = "";
	for (var i=0;i<skillCount;i++)
	{
		raw_sql += squel.insert()
			.into(tableName)
			.set("skill", allSkills[i]).toString() + ';\n';	
			//.onDupUpdate("skill", allSkills[i]).toString() + ';\n';
	}
	dumpToFile(raw_sql);
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