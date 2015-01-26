var request = require('request');
var configs = require('./config.js');
var requests = require('./requests.js');
var querystring = require('querystring');
var xmldoc = require('xmldoc');
var fs = require('fs');

var totalJobsForProvider = -1;
var currPageNumber = 1;  //Needs to be updated in each execution, the API has limits :(

var jobCount = 0; //configs.resultsPerPage * currPageNumber;  WHY THERE IS NO VOLATILE VARs IN HERE ?

var hostSite = "US";

function sendRequest(pageIndex, cb){
  var requestParams = { DeveloperKey:configs.apiKey, HostSite:hostSite, PageNumber:  pageIndex, PerPage: configs.resultsPerPage };
  request(
  { 
    method: 'GET',
    uri: requests.jobList,
    qs:requestParams,
    gzip: true
  },

  function (error, response, body) 
  {
    if (error) {cb(err,pageIndex);}    

    if (totalJobsForProvider == -1)
    {
      console.log("First request. Updating total jobs available for current provider (%s)", hostSite);

      var results = new xmldoc.XmlDocument(body);
    
      totalJobsForProvider = results.childNamed("TotalCount").val; 

      console.log("Total job count updated to %d", totalJobsForProvider);
    }

    fs.writeFile("./raw/" + hostSite + "/raw" + pageIndex + ".dat", body, function(err) {
    if(err) 
    {
        cb(err,pageIndex);
    }
    });

    jobCount = configs.resultsPerPage * pageIndex;

    if (jobCount<totalJobsForProvider){
      cb(null, pageIndex) ;
    }
  });
}

requestFinishedCallback = function(err, pageId)
{
  if (err)
    console.log("%d Page failed: %s", pageId, err );
  else
  {
    console.log("Progress: %d/%d.", jobCount, totalJobsForProvider);
    sendRequest(++currPageNumber, requestFinishedCallback);
  }
}

sendRequest(currPageNumber, requestFinishedCallback);
