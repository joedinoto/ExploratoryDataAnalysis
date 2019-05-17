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
library(dplyr)
NEI<- as.data.table(NEI)
SCC<- as.data.table(SCC)

# 5 How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

# SCC$Short.Name "Motor vehicle"
# Showing 1 to 18 of 20 entries, 15 total columns (filtered from 11,717 total entries)
# SCC$EL.Sector "road gas"
# Showing 1 to 18 of 629 entries, 15 total columns (filtered from 11,717 total entries)


roadgas <- filter(SCC, grepl("road gas",EI.Sector)) # dplyr needed for this
roadgas$SCC <- as.character(roadgas$SCC) #change from factor to character
roadgasstring <- coal$SCC #create vector of just road gasoline codes
NEIfiltered<- NEI[NEI$SCC %in% roadgasstring] # filter NEI to only road gasonline-related items
boxplot(Emissions ~ year,NEIfiltered,xlab="year",ylab="emissions")
yearmean<- NEIfiltered[,.(YearMean=mean(Emissions)),by=.(year)]
plot(yearmean)