logDataFile <- 'accessLogData.txt'
logColumns <- c("IP", "date", "HTTPstatus", "country", "state", "city")
logData <- read.table(logDataFile, sep=",", col.names=logColumns)
library(maps)
library(mapproj)

country <- unique(logData$country)
country <- sapply(country, function(countryCode){
  #trim whitespaces from the country code
  countryCode <- gsub("(^ +)|( +$)", "", countryCode)
  if(countryCode == "US"){
    countryCode<- "USA"
  }else if(countryCode == "AU"){
    countryCode<- "Australia"
  }}
)
countryMatch <-  match.map("world2", country)
colorCountry <- sapply(countryMatch, function(c){
 if(!is.na(c)) c <- "#C6DBEF"
 else c <- "#FFFFFF"
})
map('world', proj='azequalarea', orient=c(41,-74,0), boundary=TRUE, col=colorCountry, fill=TRUE)
m <- map('world',plot=FALSE)
map.grid(m, col="blue", label=FALSE, lty=2, pretty=TRUE)
map.scale()
usData <- logData[logData$state != "XX", ]
usData$state <- apply(as.matrix(usData$state), 1, function(s){
  #trim the abbreviation of whitespaces
  s <- gsub("(^ +)|( +$)", "", s)
  s <- state.name[grep(s, state.abb)]
})
states <- unique(usData$state)
stateMatch <- match.map("state", states)
colorMatch <- sapply(stateMatch, function(s){
 if(!is.na(s)) s <- "#C6DBEF"
 else s <- "#FFFFFF"
})
map("state", resolution = 0,lty = 0,projection = "azequalarea", col=colorMatch,fill=TRUE)
map("state", col = "black", fill=FALSE, add=TRUE, lty=1, lwd=1, projection="azequalarea")
map.scale()


