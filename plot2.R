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

# https://s3.amazonaws.com/assets.datacamp.com/img/blog/data+table+cheat+sheet.pdf
NEI<- as.data.table(NEI)
fips<- NEI[,.(fipsMean = mean(Emissions)),by=.(year,fips)]
bmore<- fips[fips==24510]
plot(bmore$year,bmore$fipsMean)