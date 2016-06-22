## example of how to use `makeLabels' and also making labels for round 2

source('~/Dropbox/hawaiidimensions/labels/makeLabels.R')

## make some specific labels
these.hdim <- c(5482, 8015, 8019, 12003, 6273, 6239, 6241, 4496, 4497, 4498, 4499, 4500, 
                4501, 4502, 4503, 4504, 4505, 4506, 4507, 6265, 6266, 6267, 6268, 6269, 
                6270, 6271, 6272, 6273)
these.num <- c(4, 15, 14, 15, 13, 14, 5, rep(15, 21))
makeLabels(these.hdim, 
           '~/Dropbox/hawaiiDimensions/labels', sprintf('labels_%s', Sys.Date()), 
           repID=these.num)