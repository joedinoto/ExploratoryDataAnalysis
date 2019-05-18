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


roadgas <- filter(SCC, grepl("On-Road Gasoline",EI.Sector)) # dplyr needed for this
roadgas$SCC <- as.character(roadgas$SCC) #change from factor to character
roadgasstring <- roadgas$SCC #create vector of just road gasoline codes
NEIfiltered3<- NEI[NEI$SCC %in% roadgasstring] # filter NEI to only road gasonline-related items
NEIfiltered3<- NEIfiltered3[fips %in% c("24510","06037")] # filter NEI to LA County and Bmore only
yeartotal3<- NEIfiltered3[,.(YearSum3=sum(Emissions)),by=.(year,fips)] # sum of emissions by year and fips

names(yeartotal3)<- c("year","city","YearSum3")
yeartotal3$city <- gsub("24510","Baltimore City", yeartotal3$city)
yeartotal3$city <- gsub("06037","LA County", yeartotal3$city)

# step 1 open png() device
dev.print(png, file = "Plot6.png", width = 480, height = 480)
png(file = "Plot6.png", bg = "transparent")
# step 2 plot the function
g<- ggplot(data=yeartotal3,aes(x=year,y=YearSum3,group=city))
g + geom_line(aes(color=city, linetype=city)) +
  geom_point(aes(shape=city)) +
  labs(y="PM2.5 emissions (tons)",title="Sum of PM2.5 emissions from Motor Vehicles by city") 
# step 3 close the png() device
dev.off()