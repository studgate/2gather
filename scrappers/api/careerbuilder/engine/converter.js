fs = require('fs')
var xmldoc = require('xmldoc');

var rootPath = "./raw";


var FIELD_SEPARATOR = '\t';/*'\u0001'*/;

var walk = function(dir, done) {
	var results = [];
  	fs.readdir(dir, function(err, list) {
    if (err) return done(err);
    var i = 0;
    (function next() {
      var file = list[i++];
      if (!file) return done(null, results);
      file = dir + '/' + file;
      fs.stat(file, function(err, stat) {
        if (stat && stat.isDirectory()) {
          walk(file, function(err, res) {
            results = results.concat(res);
            next();
          });
        } else {
          results.push(file);
          next();
        }
      });
    })();
  });
};

var jobsData = {};
var tags = [];

walk(rootPath, function(err, results) {
  if (err) throw err;
  
  for (var i=0;i<results.length;i++)
	{
	  	var str = fs.readFileSync(results[i]).toString();
	  	try
	  	{  		
	  		var xml = new xmldoc.XmlDocument(str);
	  		console.log("File %s read. Parsing XML.", results[i]);
	  		parseXML(xml);	  		
	  	}
	  	catch(err)
	  	{
	  		console.log("No valid XML to parse. Skipping." + err);
	  	}  	  		
	}

	console.log("Finished parse all XML files. Dumping to file.");
	dumpToCSV();
});


function parseXML(doc)
{
	var rootNodeTag = "Results";

	var rootNode = doc.childNamed(rootNodeTag); 
	

	if (rootNode.children.length == 0)
	{
		return;
	}	

	rootNode.eachChild(function(node, index, data){	 /*<JobSearchResult>* level*/		
			node.eachChild(function(node, index, data)
			{
				extractValues(node);
			});
	});	
}

function extractValues(node)
{
	var name="", value="";	
	//is a childNode
	if (node.children.length == 0)
	{
		name = node.name;
		value = node.val;		
	}
	else
	{		
		name = node.firstChild.name;
		node.eachChild(function(node, index, data)
		{

			value += " " + node.val;
		});

	}

	if (tags.indexOf(name)==-1)
	{
		console.log("New tag found: %s", name);
		tags.push(name);
	}
	if (!jobsData.hasOwnProperty(name))
	{				
		jobsData[name] = new Array(value);				
	}
	else
	{						
		jobsData[name].push(value);				
	}
}

function dumpToCSV()
{
	//console.log(FIELD_SEPARATOR);
	var keys = Object.keys(jobsData);
	var size = jobsData[keys[0]].length;
	var stream = fs.createWriteStream("dump.csv");
	  stream.once('open', function(fd) {
	  	var header = "";
		for (var j=0;j<keys.length-1;j++)
		{
			header += keys[j] + FIELD_SEPARATOR;			
		}
		header += keys[keys.length-1] + "\n";
		stream.write(header);

	  	for (var i=0;i<size;i++)
	  	{
	  		var row = "";
	  		var elCount = 1;
	  		for (var j=0;j<keys.length-1;j++)
	  		{	  			
	  			row += jobsData[keys[j]][i] + FIELD_SEPARATOR;
	  			elCount++;
	  		}	  		
	  		row += jobsData[keys[keys.length-1]][i] + "\n";

	  		if (elCount<tags.length-1)
	  			console.log("Peido: %s:" , row);
	  		else
	  			stream.write(row);
	  	}
	  stream.end();
	});
}

function dumpToSQL()
{

}