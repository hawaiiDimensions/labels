library(tools)

## main function takes vector of HDIM numbers and directory of DB

## helper functions need to pull info from database and organize that into a label

makeLabels <- function(hdim, dir, sheetName, defaultYear=2015, repID=1) {
    ## load data base
    db <- RCurl::getURL('https://docs.google.com/spreadsheets/d/1Ve2NZwNuGMteQDOoewitaANfTDXLy8StoHOPv7uGmTM/pub?output=csv')
    db <- read.csv(textConnection(db), as.is=TRUE)
#     db <- read.csv(paste(dir, 'event_table.csv', sep='/'), as.is=TRUE)
    
    ## subset database to only desired HDIM numbers
    hdim <- rep(hdim, each=repID)
    db <- db[match(hdim, db$HDIM), ]
    
    ## allow makeOneLabel function to see objects from local environment
    environment(makeOneLabel) <- environment()
    
    ## loop over db and make labels
    out <- character(nrow(db))
    for(i in 1:nrow(db)) {
        this.label <- makeOneLabel(db[i, ])
        
        if(i %% 7 == 0 & i != nrow(db)) {
        	this.label <- paste(this.label, '\\\\ \n\\vspace{0.001in} \n\n\\noindent')
        }
        
        out[i] <- this.label
    }
    
    out <- c('\\documentclass[6pt]{article}',
             '\\usepackage[margin=0.25in]{geometry}',
             '\\geometry{letterpaper}',
             '\\usepackage{graphicx}',
             '\\usepackage{setspace}',
             '\\usepackage{amssymb}',
             '\\usepackage{amsmath}',
             '\\usepackage{epstopdf}',
             '\n',
             '\\begin{document}',
             '\\noindent', 
             out,
             '\\end{document}')
    
    writeLines(out, paste(dir, '/', sheetName, '.tex', sep=''))
    system(sprintf('%s %s/%s.tex', system('which pdflatex', intern=TRUE), dir, sheetName))
    system(sprintf('rm %s/%s.aux %s/%s.log', dir, sheetName, dir, sheetName))
}

makeOneLabel <- function(x) {
    month <- c('jan', 'feb', 'mar', 'apr', 'may', 'jun', 'jul', 'aug',
               'sep', 'oct', 'nov', 'dec')
    
    with(x, {
        coll <- Collector
        coll <- coll[!(is.na(coll) | coll == '')]
        if(length(coll) < 1) {
        	coll <- '\\rule{0ex}{0ex}\\hspace{6em}'
        }
        
        # if(length(coll) > 1) {
        	# coll <- substring(coll, 1, 4)
        	# coll <- gsub('\\. ', '', coll)
        	# coll <- paste(coll, collapse=', ')
        # }

        if(grepl('beat', Method, ignore.case=TRUE) & !(is.na(TimeBegin) | TimeBegin == '')) {
            endt <- paste('--', TimeEnd, sep='')
        } else {
            endt <- ''
        }
        
        if(is.na(TimeBegin) | TimeBegin == '') {
            TimeBegin <- '\\rule{0ex}{0ex}\\hspace{4.5em}'
        }
        
        if(is.na(Date) | Date == '') {
        	date <- defaultYear
        } else {
            d <- strsplit(Date, '/')[[1]]
            date <- paste(ifelse(nchar(d[3]) == 2, paste('20', d[3], sep=''), d[3]), 
                          month[as.numeric(d[1])], 
                          d[2], 
                          sep='-')
        }
        
        paste('\\parbox{0.135\\textwidth}{\\tiny ',
              paste('HDIM', HDIM, sep=''), '; ', gsub('_', '\\\\_', Plot), '\\\\ ',
              Method, ' ', ifelse(is.na(Plant), '', Plant), ' ', BeatingDuration, '\\\\ ',
              TimeBegin, endt, '; ', date, '\\\\ ',
              paste(coll, collapse=', '), ifelse(length(coll) > 1, ' colls.', ' coll.'), 
              '}',
              sep='')
    })

}


makeLabels(4242:4252, '~/Dropbox/hawaiiDimensions/labels', 'stub3', repID=2)
