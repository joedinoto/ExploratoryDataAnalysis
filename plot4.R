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

# sum of all coal combustion sources
coal <- filter(SCC, grepl("Coal",EI.Sector)) # use dplyr to filter only coal combustion from SCC
coal$SCC <- as.character(coal$SCC) #change from factor to character
coalstring <- coal$SCC #create vector of just coal codes
NEIfiltered<- NEI[NEI$SCC %in% coalstring] # filter NEI to only coal-related items
yeartotal <- NEIfiltered[,.(YearSum=sum(Emissions)),by=.(year)]

# step 1 open png() device
dev.print(png, file = "Plot4.png", width = 480, height = 480)
png(file = "Plot4.png", bg = "transparent")
# step 2 plot the function
barplot(
  (1/100000)*(yeartotal$YearSum), # Scale the sum by 100k
  names = yeartotal$year,
  ylim=c(0,6),
  xlab="year",
  ylab="PM2.5 emissions (100k tons)",
  main="USA sum of all coal-combustion PM2.5 emissions"
  )
# step 3 close the png() device
dev.off()
