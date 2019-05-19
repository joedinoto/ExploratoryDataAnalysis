# download & unzip data
url<- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
dest <- "data.zip"
download.file(url,dest,method="curl")
unzip("data.zip")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(data.table) # data.table package, format NEI & SCC as data.tables
NEI<- as.data.table(NEI)
SCC<- as.data.table(SCC)

# I am interperting "total" to mean "SUM".
yearsum<- NEI[,.(YearSum=sum(Emissions)),by=.(year)]

# step 1 open png() device
dev.print(png, file = "Plot1.png", width = 480, height = 480)
png(file = "Plot1.png", bg = "transparent")
# step 2 plot the function
barplot(
  (1/1000000)*(yearsum$YearSum), # Scale the sum by 1M
  names = yearsum$year,
  ylim=c(0,8),
  xlab="year",
  ylab="PM2.5 emissions (millions of tons)",
  main="USA sum of all PM2.5 emissions from all sources by year"
) 
# step 3 close the png() device
dev.off()