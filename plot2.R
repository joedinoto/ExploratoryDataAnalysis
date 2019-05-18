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

# https://s3.amazonaws.com/assets.datacamp.com/img/blog/data+table+cheat+sheet.pdf

# interpreting //total// as "mean of all emissions"
# NEI<- as.data.table(NEI)
# fips<- NEI[,.(fipsMean = mean(Emissions)),by=.(year,fips)]
# bmore<- fips[fips==24510]
# plot(bmore$year,bmore$fipsMean)

# interpreting //total// as "sum of all emissions"
fipstotal<- NEI[,.(fipsSum = sum(Emissions)),by=.(year,fips)]
bmore<- fipstotal[fips==24510]

# step 1 open png() device
dev.print(png, file = "Plot2.png", width = 480, height = 480)
png(file = "Plot2.png", bg = "transparent")
# step 2 plot the function
barplot(
  (1/1000)*(bmore$fipsSum), # Scale the sum by 1k
  names = bmore$year,
  ylim=c(0,3.5),
  xlab="year",
  ylab="PM2.5 emissions (thousands of tons)",
  main="Baltimore City sum of PM2.5 emissions from all sources by year"
) 
# step 3 close the png() device
dev.off()