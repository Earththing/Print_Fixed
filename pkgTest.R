# pkgTest.R
## check for package and install it if it does not exsist, load it if it does.
# pkgTest("packagename")

pkgTest <- function(x)
{
  if (!require(x,character.only = TRUE))
  {
    install.packages(x,dep=TRUE)
    if(!require(x,character.only = TRUE)) stop("Package not found")
  }
}