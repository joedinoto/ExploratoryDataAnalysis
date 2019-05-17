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
# http://www.sthda.com/english/wiki/ggplot2-line-plot-quick-start-guide-r-software-and-data-visualization
library(ggplot2)
fips<- NEI[,.(fipsMean = mean(Emissions)),by=.(year,type,fips)]
bmore<- fips[fips==24510]
plot(bmore$year,bmore$fipsMean)
ggplot(data=bmore,aes(x=year,y=fipsMean,group=type))+geom_line(aes(color=type, linetype=type))+geom_point(aes(shape=type))