# download & unzip data
url<- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
dest <- "data.zip"
download.file(url,dest,method="curl")
unzip("data.zip")

## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(data.table) # data.table package, format NEI & SCC as data.tables
library(ggplot2)

NEI<- as.data.table(NEI)
SCC<- as.data.table(SCC)

# Total is taken to mean the sum of all emissions
fipstotal<- NEI[,.(fipsSum = sum(Emissions)),by=.(year,type,fips)]
bmore<- fipstotal[fips==24510]

# step 1 open png() device
dev.print(png, file = "Plot3.png", width = 480, height = 480)
png(file = "Plot3.png", bg = "transparent")
# step 2 plot the function
g<- ggplot(data=bmore,aes(x=year,y=fipsSum,group=type))
g + geom_line(aes(color=type, linetype=type)) +
  geom_point(aes(shape=type)) +
  labs(y="PM2.5 emissions (tons)",title="Baltimore City sum of PM2.5 emissions by type")
# step 3 close the png() device
dev.off()