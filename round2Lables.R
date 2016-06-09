## example of how to use `makeLabels' and also making labels for round 2

source('~/Dropbox/hawaiidimensions/labels/makeLabels.R')

## old call...reminder of general functionality
# makeLabels(c(5473, 5330, 5158, 5506, 5481, 10039, 6299, 6310, 5509), 
#            '~/Dropbox/hawaiiDimensions/labels', 'labels_2016-02-09', 
#            repID=c(26, 18, 12, 10, 9, 9, 18, 16, 1))


# # get copy of database and find round 2
# db <- RCurl::getURL('https://docs.google.com/spreadsheets/d/1Ve2NZwNuGMteQDOoewitaANfTDXLy8StoHOPv7uGmTM/pub?output=csv')
# db <- read.csv(textConnection(db), as.is=TRUE)
# hdimRound2 <- db$HDIM[as.Date(db$Date, format='%m/%d/%Y') > as.Date('7/1/15', format='%m/%d/%Y')]
# hdimRound2 <- hdimRound2[!is.na(hdimRound2)]


# ## make labels for those hdim, 18 each
# makeLabels(hdimRound2, '~/Dropbox/hawaiiDimensions/labels', 'labels_round2', repID=18)

## make some specific labels
these.hdim <- c(8007, 8005, 8006, 6226, 8000, 8001, 8002, 8003, 8004, 8008, 8009)
these.num <- c(16, 11, 15, rep(18, 8))
makeLabels(these.hdim, 
           '~/Dropbox/hawaiiDimensions/labels', 'labels_2016-06-10', 
           repID=these.num)