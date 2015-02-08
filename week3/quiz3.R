## Quiz 3.
# Problem 1.
# What is required for an R package to pass R CMD check without 
# any warnings or errors?
# An explicit software license
# DESCRIPTION file

# Problem 2.
library(pryr)
ftype(mean) # [1] "s3"  "generic"
            # a generic function in a fresh installation of R, 
            # with only the default packages loaded
ftype(predict) # [1] "s3" "generic"
               # a generic function in a fresh installation of R, 
               # with only the default packages loaded
ftype(show) # [1] "s4"  "generic"
ftype(lm) # [1] "function"
ftype(colSums) # [1] "internal"
ftype(dgamma) # [1] "function"

# Problem 3.
showMethods("show")
getMethod(show) # used to obtain the function body for an S4 method function

# Problem 4.
# model.require (optional)
# model.transform (optional)
# model.predict (required)

# Problem 5. 
#' This function calculates the mean
#' 
#' @param x is a numeric vector
#' @return the mean of x
#' @export
#' @examples 
#' x <- 1:10
#' createmean(x)
