# import required library
library(RJSONIO)
library(tidyr)
library(data.table) #Transpose
# extracting data from the website
raw <- fromJSON("http://ddragon.leagueoflegends.com/cdn/11.12.1/data/en_US/champion.json")

#Data Node
champs <- raw[['data']]


#id
id <- as.vector(sapply(champs, function(x) x[["id"]]))

#key = no space name
key <- as.vector(sapply(champs, function(x) x[["key"]]))

#name
name <- as.vector(sapply(champs, function(x) x[["name"]]))

#title
title <- as.vector(sapply(champs, function(x) x[["title"]]))

#blurb
#...

#info
#Parse through info list
info <- sapply(champs, function(x) x[["info"]])
infoDF <- as.data.frame(info)
t_infoDF <- as.data.frame(t(infoDF))
t_infoDF$attack <- unlist(t_infoDF$attack, use.names = F)
t_infoDF$defense <- unlist(t_infoDF$defense, use.names = F)
t_infoDF$magic <- unlist(t_infoDF$magic, use.names = F)
t_infoDF$difficulty <- unlist(t_infoDF$difficulty, use.names = F)

# 
# unlist(t_infoDF$attack, use.names = F)
# 
# #t_infoDF2 <- as.data.frame(do.call(rbind, t_infoDF))
# 
# 
# head(do.call(rbind, t_infoDF))
# t_infoDF <- unlist(t_infoDF)
# > View(unlist(t_statsDF, use.names = F))

#image
#.....


#tags
#Parse through tags list
tags <- sapply(champs, function(x) x[["tags"]])
tagsDF <- as.data.frame(tags)
t_tagsDF <- as.data.frame(t(tagsDF))
names(t_tagsDF) <- c("tag1", "tags2")

#partype (resource type)
partype <- sapply(champs, function(x) x[["partype"]])

#stats
stats <- sapply(champs, function(x) x[["stats"]])
statsDF <- as.data.frame(stats)
t_statsDF <- as.data.frame(t(statsDF))
varStats <- length(names(t_statsDF))
for (i in 1:varStats){
  t_statsDF[,i] <- unlist(t_statsDF[,i], use.names = F)
  #t_infoDF$attack <- unlist(t_infoDF$attack, use.names = F)
}



allDF <- as.data.frame(cbind(name, title, t_infoDF, t_tagsDF, t_statsDF))



#--------------------

for (i in 1:length(allDF)){
  allDF[,i] <- as.vector(allDF[,i])
}


sapply(allDF, function(x) as.vector(allDF[x]))
head(allDF)

#All variables

# "version" "id"      "key"     "name"    "title"   "blurb"   "info"    "image"   "tags"    "partype" "stats"  
varKeys <- names(champs$Aatrox)
idVec <- c("version", "blurb", "info"
varKeys <- varKeys[-("blurb", "image", "stats")]

#Empty DF
tempDF <- data.frame(matrix(,nrow = 155, ncol = 10))

getVar <- function(varStr,i){
  tempVec <- sapply(champs, function(x) x[[varStr]])
  tempDF[,i] <- tempVec
}


for (i in 1:10){
  getVar(varKeys[i], i)
}

for (i in 1:length(champs)){
  print(sapply(champs, function(x) x[["tags"]]))
}

#----------------



#----------------


