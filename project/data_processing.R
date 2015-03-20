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

# Exploratory data analysis
sum(is.na(data)) # 0
length(unique(data$set_id)) # 9944
table(data$year) # 1950 - 2015
length(table(data$year)) # 64
years <- sort(unique(data$year))
length(table(data$theme)) # 98
themes <- sort(unique(data$theme))
# sqldf("SELECT distinct year FROM data") 

## Helper functions

#' Aggregate dataset by themes
#' 
#' @param dt data.table
#' @param minYear
#' @param maxYear
#' @param themes
#' @return result data.table
#' 
groupByTheme <- function(dt, minYear, maxYear, themes) {
    # use pipelining
    result <- dt %>% filter(year >= minYear, year <= maxYear,
                            theme %in% themes) 
    result <- datatable(result, options = list(iDisplayLength = 50))
    return(result)
    # The following does not work
    #     fn$sqldf("SELECT * FROM data 
    #          WHERE year >= $minYear and year <= $maxYear
    #          and theme in $themes")

    #return(data.table(result))
}

#' Aggregate dataset by year
#' 
#' @param dt data.table
#' @param minYear
#' @param maxYear
#' @param themes
#' @return data.table 2 columns
#'
groupByYear <- function(dt, minYear, maxYear, themes) {
    result <- dt %>% filter(year >= minYear, year <= maxYear,
                  theme %in% themes) %>% 
    group_by(year)  %>% summarise(count = n()) %>%
    arrange(year)
    return(result)
}

#' Plot number of themes by year
#' 
#' @param dt data.table
#' @param dom
#' @param xAxisLabel year
#' @param yAxisLabel count
#' @return themesByYear plot
plotThemesCountByYear <- function(dt, dom = "themesByYear", 
                                  xAxisLabel = "Year",
                                  yAxisLabel = "Count") {
    themesByYear <- nPlot(
        count ~ year,
        data = dt,
        type = "lineChart", dom = dom, width = 650
    )
    themesByYear$chart(margin = list(left = 100))
    themesByYear$yAxis(axisLabel = yAxisLabel, width = 80)
    themesByYear$xAxis(axisLabel = xAxisLabel, width = 70)
    themesByYear
}
