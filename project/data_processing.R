# setwd("./Desktop/Online Coursera/Coursera-Developing-Data-Products/project/")

# required libraries
require(data.table)
library(sqldf)
library(dplyr)

# read data
data <- fread("./data/sets.csv")
head(data)
setnames(data, "t1", "theme")
setnames(data, "descr", "name")

# exploratory data analysis
sum(is.na(data)) # 0
length(unique(data$set_id)) # 9944
table(data$year) # 1950 - 2015
length(table(data$year)) # 64
# sqldf("SELECT distinct year FROM data") # Also 64


