var fs = require('fs')
var xmldoc = require('xmldoc');

var jobsData = {};
var tags = [];

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


function getAllFilesAsXml(rootPath, cb)
{
    console.log("Walk through %s started.", rootPath);
    walk(rootPath, function(err, results) {

      if (err)
      {
        cb(err, null)
      }
      console.log("Walk through %s ended.", rootPath);
      console.log("Convertion to XML started.");
      var docs=[];      
      for (var i=0;i<results.length;i++)
      {
        var str = fs.readFileSync(results[i]).toString();
        try
        {     
          var xml = new xmldoc.XmlDocument(str);
          docs.push(xml);
        }
        catch(err)
        {
          console.log("No valid XML to parse. Skipping." + err);
        }         
    }      
    cb(null,docs);
  });
}

function getFilesAtOnce(rootPath, cb)
{  
    //console.log("Walk through %s started.", rootPath);

    walk(rootPath, function(err, results) {
      
      //console.log("Found %d files in %s.", results.length, rootPath);

      if (err)
      {
        cb(err, null)
      }
            
      for (var i=0;i<results.length;i++)
      {        
        var str = fs.readFileSync(results[i]).toString();
        try
        {     
          var xml = new xmldoc.XmlDocument(str);
          cb(null, xml);
        }
        catch(err)
        {
          console.log("No valid XML to parse. Skipping." + err);
        }         
    }    
  });
}

module.exports.getAll = getAllFilesAsXml;
module.exports.getEach = getFilesAtOnce;