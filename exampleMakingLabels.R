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

## extract hippnet plots
these.plots <- colEvent[grep('hippnet', colEvent$Plot), ]
these.plots <- these.plots[!(these.plots$Method %in% c('canopy clipping', 'soil extraction')), ]

## make labels
makeLabels(these.plots$HDIM, '~/Dropbox/hawaiiDimensions/labels', 'labels_hippnet', repID=18)