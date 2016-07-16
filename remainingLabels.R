## labels for rest of special project

## label making function
source('~/Dropbox/hawaiidimensions/labels/makeLabels.R')

## function to read-in google drive tables
readGoogle <- function(u) {
    dat <- RCurl::getURL(u)
    read.csv(textConnection(dat), as.is=TRUE)
}

## the database
colEvent <- readGoogle('https://docs.google.com/spreadsheets/d/1Ve2NZwNuGMteQDOoewitaANfTDXLy8StoHOPv7uGmTM/pub?gid=0&single=true&output=csv')
colEvent <- colEvent[colEvent$HDIM > 999 & !is.na(colEvent$Plot) & !is.na(colEvent$Date) & !is.na(colEvent$Method), ]
colEvent$Date <- as.Date(colEvent$Date, '%m/%d/%Y')



## done HDIMs
done <- c(8006, 6244, 6239, 6225, 8573, 6753, 4503, 6752, 6271, 6269, 6648, 6647, 
          6638, 6639, 6641, 8576, 8540, 8574, 6646, 6642, 6643, 6645, 8005, 8007, 
          6226, 6241, 6573, 6268, 6278, 4497, 4506, 4496, 4507, 8541, 4498, 6637, 
          6640, 8577, 6273, 8003, 6754, 8000, 8004, 8002, 8001, 8009, 6577, 6575, 
          4500, 4501, 4502, 4504, 4505, 6265, 4499, 6266, 8575, 4214)

## sites we need
sites <- c('kamakou_41', 'waikamoi_32', 'kohalaYng_10', 'olaa_10', 'laupLSAG_10',
           'kaiholenaYng_10', 'kokee_22')

## get hdim for those sites and sort by site
temp <- colEvent[colEvent$Plot %in% sites, c('HDIM', 'Plot', 'Method', 'Date')]
temp <- temp[temp$Date > as.Date('6/24/2015', '%m/%d/%Y') & 
                 !grepl('clipping|soil|InsectaZooka', temp$Method), ]
all.these.hdim <- temp$HDIM

temp <- temp[temp$Plot != 'laupLSAG_10', ]
these.hdim <- temp[order(temp$Plot), 'HDIM']
these.hdim <- these.hdim[!(these.hdim %in% done)]
these.hdim <- c(these.hdim, 8575)

## make labels
makeLabels(these.hdim, '~/Dropbox/hawaiiDimensions/labels', 'labels_remaining', repID=18)

## check on completeness

allDone <- colEvent[colEvent$HDIM %in% c(all.these.hdim, done), ]
progress <- aggregate(allDone$HDIM, list(plot=allDone$Plot, method=allDone$Method), function(x) length(unique(x)))
progress[order(progress$plot), ]

