# Quiz 1.
# Problem 1.
library(manipulate)
myPlot <- function(s) {
  plot(cars$dist - mean(cars$dist), cars$speed - mean(cars$speed))
  abline(0, s)
}
manipulate(myPlot(s), s = slider(0, 2, step = 0.1))

# Problem 2.
# It was pointed out in the forums that rCharts may need 
# to be installed from devtools if you have a recent version 
# of R. Here's the note from Ramnath
# 
# https://github.com/ramnathv/rMaps/issues/54
# 
# The devtools package on cran is a must to install. 
# If no base64enc package error, do install.packages('base64enc').
library(rCharts)
dTable(airquality, sPaginationType = "full_numbers")

# Problem 3.
# A basic shiny data product requires: 
# ui.R and server.R file or a A server.R file and 
# a directory called www containing the relevant html files.

# Problem 4.
library(shiny)
shinyUI(pageWithSidebar(
  headerPanel("Data science FTW!"),
  sidebarPanel(
    h2('Big text'), # Missing a comma in the sidebar panel
    h3('Sidebar')
  ),
  mainPanel(
    h3('Main Panel text')
  )
))

# Problem 5.
runExample("01_hello")
runApp("app1")
# The server.R output name isn't the same as the plotOutput 
# command used in ui.R.
# Change myHist to newHist!