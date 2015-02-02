var path = "../raw/dids&skills.csv";

var xmlloader = require("../helpers/XMLLoader.js");
var fs = require('fs');
var wstream = fs.createWriteStream(path);

var FIELD_SEP = '\u0001';

function extractRelevantFields(xml)
{	
	var rootNodeTag = "Results";

	var rootNode = xml.childNamed(rootNodeTag); 
	
	if (rootNode.children.length == 0)
	{
		return;
	}		
	var did;
	var skills;
	rootNode.eachChild(function(node, index, data){	 /*each JobSearchResult */
		did = node.childNamed("DID").val;
		skills = ""		
		var skillsNode = node.childNamed("Skills");
		skillsNode.eachChild(function(skillNode, index, data)
		{
			skills += skillNode.val + ','
		})		
		wstream.write(did + FIELD_SEP + skills + '\n');
	});		
}

xmlloader.getEach("../raw", function(err, doc, hasFinished){
	if (err)
	{	
		console.log("ERROR: " + err);
		throw "error";
	}	
	else		
	{
		if (!hasFinished){
			extractRelevantFields(doc);
			doc=undefined; //no longer required
		}
		else
		{
			wstream.end();
		}
	}
});
