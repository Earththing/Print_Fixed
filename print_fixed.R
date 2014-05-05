# print-fixed.R
# Function to print a dataset to a text file in a pleasing fixed width format

# Make sure require packages are loaded
source("pkgTest.R")
pkgTest("gdata")

#
print.fixed <- function(x, file=NULL, style='t')
{
  format <- write.fwf(x, file="temp.txt", formatInfo=TRUE) # IDEA: random file name and then delete afterwards
  f2 <- write.fwf(format, file="temp.txt", formatInfo=TRUE)
  colw <- f2[1,4]
  cwidth <- NULL
  names <- data.frame(t(data.frame(names(x)))) 
  i <- 0
  if(style == 't'){
    for(i in 1:nrow(format)){
      cwidth <- c(cwidth, ifelse(format[i,4]>nchar(format[i,1]),format[i,4],nchar(format[i,1])))
    }
  } 
  write.fwf(names, file="ff.txt", width=cwidth, append=FALSE, colnames=FALSE, justify="left")
  write.fwf(x, file="ff.txt", width=cwidth, append=TRUE, colnames=FALSE)
}
