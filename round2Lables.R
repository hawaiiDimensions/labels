## example of how to use `makeLabels' and also making labels for round 2

source('~/Dropbox/hawaiidimensions/labels/makeLabels.R')

## make some specific labels
these.hdim <- c(6753, 8573, 6578, 6575, 6577, 6573, 6261)
these.num <- c(7, 11, 7, 13, 11, 8, 12)
makeLabels(these.hdim, 
           '~/Dropbox/hawaiiDimensions/labels', sprintf('labels_%s', Sys.Date()), 
           repID=these.num)