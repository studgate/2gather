library(packrat)
library(rjson)

setwd(dir = "../../scrappers/api/careerbuilder/engine/raw/")


json_file <- "raw1.json"
json_data <- fromJSON(paste(readLines(json_file), collapse=""))
dt<-data.frame(json_data)
