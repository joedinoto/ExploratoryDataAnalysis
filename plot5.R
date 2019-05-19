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

# sum of all motor vehicle sources
roadgas <- filter(SCC, grepl("On-Road Gasoline",EI.Sector)) # dplyr needed for this
roadgas$SCC <- as.character(roadgas$SCC) #change from factor to character
roadgasstring <- roadgas$SCC #create vector of just road gasoline codes
NEIfiltered2<- NEI[NEI$SCC %in% roadgasstring] # filter NEI to only road gasonline-related items
NEIfiltered2<- NEIfiltered2[NEIfiltered2$Emissions>=0 & NEIfiltered2$fips==24510,] # filter NEI to emissions>0 and Bmore only
yeartotal2<- NEIfiltered2[,.(YearSum2=sum(Emissions)),by=.(year)] # sum of emissions by year

# step 1 open png() device
dev.print(png, file = "Plot5.png", width = 480, height = 480)
png(file = "Plot5.png", bg = "transparent")
# step 2 plot the function
barplot(
  (1)*(yeartotal2$YearSum2),
  names = yeartotal2$year,
  ylim=c(0,145),
  xlab="year",
  ylab="PM2.5 emissions (tons)",
  main="Baltimore City sum of PM2.5 emissions from motor vehicles"
) 
# step 3 close the png() device
dev.off()