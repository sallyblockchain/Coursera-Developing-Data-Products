# setwd("./Desktop/Online Coursera/Coursera-Developing-Data-Products/project/")

# Load required libraries
require(data.table)
library(sqldf)
library(dplyr)
library(DT)

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

# Helper functions
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

