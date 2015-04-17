# setwd("./Desktop/Online Coursera/Coursera-Developing-Data-Products/project/")

# Load required libraries
require(data.table)
# library(sqldf)
library(dplyr)
library(DT)
library(rCharts)

# Read data
data <- fread("./data/sets.csv")
head(data)
setnames(data, "t1", "theme")
setnames(data, "descr", "name")
setnames(data, "set_id", "setId")
# data$miniFigure <- as.numeric(data$theme=="Collectible Minifigures")
# Exploratory data analysis
sum(is.na(data)) # 0
length(unique(data$setId)) # 10036
table(data$year) # 1950 - 2015
length(table(data$year)) # 64
years <- sort(unique(data$year))
length(table(data$theme)) # 100
themes <- sort(unique(data$theme))
# sqldf("SELECT distinct year FROM data") 


## Helper functions

#' Aggregate dataset by year
#' 
#' @param dt data.table
#' @param minYear
#' @param maxYear
#' @param minPiece
#' @param maxPiece
#' @param themes
#' @return data.table
#'
groupByYearPiece <- function(dt, minYear, maxYear, minPiece,
                             maxPiece, themes) {
    result <- dt %>% filter(year >= minYear, year <= maxYear,
                            pieces >= minPiece, pieces <= maxPiece,
                            theme %in% themes) 
    return(result)
}

#' Aggregate dataset by themes
#' 
#' @param dt data.table
#' @param minYear
#' @param maxYear
#' @param minPiece
#' @param maxPiece
#' @param themes
#' @return result data.table
#' 
groupByTheme <- function(dt, minYear, maxYear, 
                         minPiece, maxPiece, themes) {
    # use pipelining
    # print(dim(dt))
    dt <- groupByYearPiece(dt, minYear, maxYear, minPiece,
                           maxPiece, themes) 
    # print(dim(result))
    result <- datatable(dt, options = list(iDisplayLength = 50))
    return(result)
    # The following does not work
    #     fn$sqldf("SELECT * FROM data 
    #          WHERE year >= $minYear and year <= $maxYear
    #          and theme in $themes")

    #return(data.table(result))
}

#' Aggregate dataset by year to get total count of themes
#' 
#' @param dt data.table
#' @param minYear
#' @param maxYear
#' @param minPiece
#' @param maxPiece
#' @param themes
#' @return data.table 2 columns
#'
groupByYearAgg <- function(dt, minYear, maxYear, minPiece,
                           maxPiece, themes) {
    dt <- groupByYearPiece(dt, minYear, maxYear, minPiece,
                      maxPiece, themes)
    result <- dt %>% 
            group_by(year)  %>% 
            summarise(count = n()) %>%
            arrange(year)
    return(result)
}

#' Aggregate dataset by year to get total count of average
#' number of pieces
#' 
#' @param dt data.table
#' @param minYear
#' @param maxYear
#' @param minPiece
#' @param maxPiece
#' @param themes
#' @return data.table 2 columns
#'
groupByPieceAvg <- function(dt,  minYear, maxYear, minPiece,
                            maxPiece, themes) {
    dt <- groupByYearPiece(dt, minYear, maxYear, minPiece,
                           maxPiece, themes)
    result <- dt %>% 
            group_by(year) %>% 
            summarise(avg = mean(pieces)) %>%
            arrange(year)
    return(result)      
}

#' Average pieces for each theme
#' 
#' @param dt data.table
#' @param minYear
#' @param maxYear
#' @param minPiece
#' @param maxPiece
#' @param themes
#' @return data.table 2 columns
#'
groupByPieceThemeAvg <- function(dt,  minYear, maxYear, minPiece,
                                 maxPiece, themes) {
    dt <- groupByYearPiece(dt, minYear, maxYear, minPiece,
                           maxPiece, themes)
    result <- dt %>% 
            group_by(theme) %>%
            summarise(avgPieces = mean(pieces)) %>%
            arrange(theme)
    return(result)
}

#' Plot number of themes by year
#' 
#' @param dt data.table
#' @param dom
#' @param xAxisLabel year
#' @param yAxisLabel number of themes
#' @return themesByYear plot
plotThemesCountByYear <- function(dt, dom = "themesByYear", 
                                  xAxisLabel = "Year",
                                  yAxisLabel = "Number of Themes") {
    themesByYear <- nPlot(
        count ~ year,
        data = dt,
        #type = "lineChart", 
        type = "multiBarChart",
        dom = dom, width = 650
    )
    themesByYear$chart(margin = list(left = 100))
    themesByYear$yAxis(axisLabel = yAxisLabel, width = 80)
    themesByYear$xAxis(axisLabel = xAxisLabel, width = 70)
    themesByYear
}

#' Plot number of pieces by year
#' 
#' @param dt data.table
#' @param dom
#' @param xAxisLabel year
#' @param yAxisLabel number of pieces
#' @return plotPiecesByYear plot
plotPiecesByYear <- function(dt, dom = "piecesByYear", 
                             xAxisLabel = "Year", 
                             yAxisLabel = "Number of Pieces") {
    piecesByYear <- nPlot(
        pieces ~ year,
        data = dt,
        #         group = "year",
        type = "scatterChart",
        dom = dom, width = 650
    )
    piecesByYear$chart(margin = list(left = 100), 
                       showDistX = TRUE,
                       showDistY = TRUE)
    piecesByYear$chart(color = c('green', 'orange', 'blue'))
    piecesByYear$chart(tooltipContent = "#! function(key, x, y, e){ 
  return '<h5><b>Set Name</b>: ' + e.point.name + '<br>'
    + '<b>Set ID</b>: ' + e.point.setId  
    + '</h5>'
    
} !#") # data[data$pieces==y&data$year==x, ]$name
    piecesByYear$yAxis(axisLabel = yAxisLabel, width = 80)
    piecesByYear$xAxis(axisLabel = xAxisLabel, width = 70)
    #     piecesByYear$chart(useInteractiveGuideline = TRUE)
    piecesByYear
}

#' Plot number of average pieces by year
#' 
#' @param dt data.table
#' @param dom
#' @param xAxisLabel year
#' @param yAxisLabel number of pieces
#' @return themesByYear plot
plotPiecesByYearAvg <- function(dt, dom = "piecesByYearAvg", 
                             xAxisLabel = "Year",
                             yAxisLabel = "Number of Pieces") {

    piecesByYearAvg <- nPlot(
        avg ~ year,
        data = dt,
        type = "lineChart",
        dom = dom, width = 650
    )
    piecesByYearAvg$chart(margin = list(left = 100))
    piecesByYearAvg$chart(color = c('orange', 'blue', 'green'))
    piecesByYearAvg$yAxis(axisLabel = yAxisLabel, width = 80)
    piecesByYearAvg$xAxis(axisLabel = xAxisLabel, width = 70)
    piecesByYearAvg
    
}

#' Plot number of average pieces by theme
#' 
#' @param dt data.table
#' @param dom
#' @param xAxisLabel theme
#' @param yAxisLabel number of pieces
#' @return piecesByThemeAvg plot
plotPiecesByThemeAvg <- function(dt, dom = "piecesByThemeAvg", 
                                 xAxisLabel = "Themes", 
                                 yAxisLabel = "Number of Pieces") {
    piecesByThemeAvg <- nPlot(
        avgPieces ~ theme,
        data = dt,
        type = "multiBarChart",
        dom = dom, width = 650
    )
    piecesByThemeAvg$chart(margin = list(left = 100))
    piecesByThemeAvg$chart(color = c('pink', 'blue', 'green'))
    piecesByThemeAvg$yAxis(axisLabel = yAxisLabel, width = 80)
    piecesByThemeAvg$xAxis(axisLabel = xAxisLabel, width = 200,
                           rotateLabels = -20, height = 200)
    piecesByThemeAvg
    
}
