# print-fixed.R
# Function to print a dataset to a text file in a pleasing fixed width format

# Make sure require packages are loaded
source("pkgTest.R")
pkgTest("gdata")

#
print.fixed <- function(x, file=NULL, style="t", border=" ")
{
  format <- write.fwf(x, file=file, formatInfo=TRUE) # IDEA: random file name and then delete afterwards # Capture the format info in a varable
  f2 <- write.fwf(format, file=file, formatInfo=TRUE) # Get the fomatting on the format information
  colw <- f2[1,4] # Get the widest column name width
  cwidth <- NULL
  names <- data.frame(t(data.frame(names(x)))) # Create a names data.frame with the column names in a column
  i <- 0
  if(style == 't'){
    for(i in 1:nrow(format)){ # Look at each column name, and set the width to be the greater of either the columnname or data and store in a vector
      cwidth <- c(cwidth, ifelse(format[i,4]>nchar(format[i,1]),format[i,4],nchar(format[i,1])))
    }
  } 
  if(style == 'e'){
    cwidth <- rep(ifelse(colw<=max(format$width), max(format$width), colw), nrow(format)) #find the max of colum or data length and set all colums to that length
  }
  if(border=="l"){
    csep <- "|"
    tsep <- "-"
  }else if(border=="d"){
    csep <- "|"
    tsep <- "="
  }else if(border==" "){
    csep <- " "
    tsep <- " "
  }
  write.fwf(names, file=file, width=cwidth, append=FALSE, colnames=FALSE, justify="left", sep=csep) # write the names to the file
  if(border != " ") {
    xxx <- paste(rep_len(tsep,sum(cwidth)+nrow(format)), collapse='')
    cat(xxx,file=file,append = TRUE, "\n")
  }
  write.fwf(x, file=file, width=cwidth, append=TRUE, colnames=FALSE, sep=csep) # write the data to the file
}
