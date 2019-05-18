# download & unzip data
url<- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
dest <- "data.zip"
download.file(url,dest,method="curl")
unzip("data.zip")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(data.table) # data.table package, format NEI & SCC as data.tables
library(dplyr)
NEI<- as.data.table(NEI)
SCC<- as.data.table(SCC)

# Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

# SCC - El.Sector "Coal"
# Showing 99 to 99 of 99 entries, 15 total columns (filtered from 11,717 total entries)
# Look up regular expressions 
# look up how to merge data sets
# https://github.com/DataScienceSpecialization/courses/blob/master/04_ExploratoryAnalysis/CaseStudy/script.R

coal <- filter(SCC, grepl("Coal",EI.Sector)) # dplyr needed for this
coal$SCC <- as.character(coal$SCC) #change from factor to character
coalstring <- coal$SCC #create vector of just coal codes
NEIfiltered<- NEI[NEI$SCC %in% coalstring] # filter NEI to only coal-related items
boxplot(Emissions ~ year,NEIfiltered,xlab="year",ylab="emissions")
yearmean<- NEIfiltered[,.(YearMean=mean(Emissions)),by=.(year)]
plot(yearmean)