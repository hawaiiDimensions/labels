## example of how to use `makeLabels' and also making labels for round 2

source('~/Dropbox/hawaiidimensions/labels/makeLabels.R')

## package to interface with web
library(RCurl)

readGoogle <- function(u) {
    dat <- getURL(u)
    read.csv(textConnection(dat), as.is=TRUE)
}

## the database (read it and write it as old version)
colEvent <- readGoogle('https://docs.google.com/spreadsheets/d/1Ve2NZwNuGMteQDOoewitaANfTDXLy8StoHOPv7uGmTM/pub?gid=0&single=true&output=csv')
laup10 <- colEvent[grep('laupLSAG_10', colEvent$Plot), ]
laup10 <- laup10$HDIM[as.Date(laup10$Date, '%m/%d/%Y') > as.Date('2015/6/1') & laup10$HDIM > 999]


## make some specific labels
these.hdim <- c(6753, 8573, 6578, 6575, 6577, 6573, 6261, laup10)
these.num <- c(7, 11, 7, 13, 11, 8, 12, rep(18, length(laup10)))
makeLabels(these.hdim, 
           '~/Dropbox/hawaiiDimensions/labels', sprintf('labels_%s', Sys.Date()), 
           repID=these.num)