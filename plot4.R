# download data
url<- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
dest <- "data.zip"
download.file(url,dest,method="curl")
# unzip data
unzip("data.zip")
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(data.table) # data.table package, format NEI & SCC as data.tables
NEI<- as.data.table(NEI)
SCC<- as.data.table(SCC)

# SCC - El.Sector "Coal"
# Showing 99 to 99 of 99 entries, 15 total columns (filtered from 11,717 total entries)
# Look up regular expressions 
# look up how to merge data sets
# https://github.com/DataScienceSpecialization/courses/blob/master/04_ExploratoryAnalysis/CaseStudy/script.R

SCCfiltered<- SCC[grepl("Coal",SCC$EI.Sector),]