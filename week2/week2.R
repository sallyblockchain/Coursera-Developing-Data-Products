## Slidify - data meets presentation
# knitr, markdown, js for HTML5 presentations
library(devtools)
# install_github('slidify', 'ramnathv')
# install_github('slidifyLibraries', 'ramnathv')
library(slidify)
getwd()
setwd("./Desktop/Online Coursera/Coursera-Developing-Data-Products/week2/")
author("sally")
slidify("index.Rmd")
library(knitr)
browseURL("./index.html")
# browseURL("http://www.r-project.org")
# publish_github(user, repo)

# HTML5 Deck Framework: Mathjax

# http://xiaodan.github.io/Coursera-Developing-Data-Products/week2/test.html