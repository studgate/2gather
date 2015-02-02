var request = require('request');
var configs = require('../helpers/config.js');
var requests = require('../helpers//requests.js');
var querystring = require('querystring');
var xmldoc = require('xmldoc');
var fs = require('fs');

var countryCodes = ["AH", "B1", "BE", "CA", "CC", "CE", "CH", "CN", "CP", "CS", "CY", "DE", "DK", "E1", "ER", "ES", "EU", "F1", "FR", "GC", "GR", "I1", "IE", "IN", "IT", "J1", "JC", "JS", "LJ", "M1", "MY", "NL", "NO", "PD", "PI", "PL", "RM", "RO", "RX", "S1", "SE", "SF", "SG", "T1", "T2", "T3", "UK", "US", "WH", "WM", "WR"];

function sendRequest(index, cb){
  var requestParams = { DeveloperKey:configs.apiKey,  CountryCode: countryCodes[index]};
  request(
  { 
    method: 'GET',
    uri: requests.listIndustry,
    qs:requestParams,
    gzip: true
  },

  function (error, response, body) 
  {
    if (error) {cb(err, index);}        

    fs.writeFile("../raw/industries/" + countryCodes[index] + ".xml", body, function(err) {
          cb(err, index);
    });    
  });
}

requestFinishedCallback = function(err, index)
{
  if (err)
    console.log("Request for countryCode %s failed. ERR: %s", err);
  else
  {
    index += 1;
    if (index <= countryCodes.length){
      console.log("Progress %d/%d complete", index, countryCodes.length);
      sendRequest(index, requestFinishedCallback);
    }
  }
}

index = 0;
if (!fs.existsSync("../raw/industries/")){
    fs.mkdirSync("../raw/industries/");
}

sendRequest(index, requestFinishedCallback);
