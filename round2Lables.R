## example of how to use `makeLabels' and also making labels for round 2

source('~/Dropbox/hawaiidimensions/labels/makeLabels.R')

## make some specific labels
these.hdim <- c(8574, 8576, 8577, 8540, 8541, 6002, 6008, 6642, 6643, 6646, 6752, 6754)
these.num <- c(10, 20, 9, 8, 12, 15, 15, 3, 3, 3, 8, 14)
makeLabels(these.hdim, 
           '~/Dropbox/hawaiiDimensions/labels', sprintf('labels_%s', Sys.Date()), 
           repID=these.num)