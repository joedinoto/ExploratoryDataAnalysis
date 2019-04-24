# Week 1 lectures
# https://github.com/DataScienceSpecialization/courses/blob/master/04_ExploratoryAnalysis/exploratoryGraphs/index.md

unzip("daily_aqi_by_county_2018.zip")
pollution <- read.csv("daily_aqi_by_county_2018.csv")
head(pollution)
summary(pollution)
str(pollution)
summary(pollution$AQI)
boxplot(pollution$AQI, col = "blue")
hist(pollution$AQI, col = "green")
rug(pollution$AQI)
hist(pollution$AQI, col = "green", breaks = 100)
#rug(pollution$AQI)
boxplot(pollution$AQI, col = "blue")
abline(h = 39)
boxplot(AQI ~ Category, data = pollution, col = "red")

#Histogram and boxplot
library(datasets)
hist(airquality$Ozone)
with(airquality,plot(Wind,Ozone))
# Several histograms
airquality<- transform(airquality,Month=factor(Month))
boxplot(Ozone ~ Month, airquality,xlab="Month",ylab ="Ozone (ppb)")

# The par() function for global graphics parameters
# mfrow - number of plots per row, column (plots are filled row-wise)
# mfcol - "" - (plots are filled column-wise)

# Make the month of May blue dots
with(airquality,plot(Wind,Ozone, main="Ozone and Wind in NYC"))
with(subset(airquality,Month==5), points(Wind, Ozone, col="blue"))

# Make the month of May blue dots,other red, and add legend 
with(airquality,plot(Wind,Ozone, main="Ozone and Wind in NYC", type="n"))
with(subset(airquality,Month==5), points(Wind, Ozone, col="blue"))
with(subset(airquality,Month!=5), points(Wind, Ozone, col="red"))
legend("topright",pch=1,col=c("blue","red"),legend=c("May","Other Months"))


# scatterplot with linear model
with(airquality,plot(Wind,Ozone, main="Ozone and Wind in NYC", pch=20))
model<- lm(Ozone ~ Wind, airquality)
abline(model,lwd=2)

# 2 plots side-by-side
par(mfrow=c(1,2)) # 1 row, 2 columns
with(airquality,{
  plot(Wind,Ozone,main="Ozone and Wind")
  plot(Solar.R,Ozone,main="Ozone and Solar Radiation")
})

# 3 plots side-by-side
par(mfrow=c(1,3),mar=c(4,4,2,1),oma=c(0,0,2,0)) # inner margins smaller than default, # outer margins bigger than default
#par(mfrow=c(1,3)) #default margins
with(airquality,{
  plot(Wind,Ozone, main="Ozone & Wind")
  plot(Solar.R,Ozone,main= "Ozone & Solar Radiation")
  plot(Temp,Ozone, main = "Ozone & Temp")
  mtext("Ozone and Weather in NYC",outer=TRUE)
})




x<- rnorm(100)
hist(x)
y<- rnorm(100)
plot(x,y)
plot(x,y,pch=19)
plot(x,y,pch=2)
title("scatterplot")
text(-2,-2,"label")
legend("topleft",legend="data")
fit<- lm(x~y)
abline(fit,lwd=3,col="blue")

# a scatterplot
plot(x,y,xlab="weight",ylab="height",main="scatterplot",pch=20)
legend("topright",legend="data",pch=20)
fit <- lm(x~y)
abline(fit,lwd=3,col="red")

z<- rpois(100,2)
par(mfrow=c(2,1))
plot(x,y,pch=20)
plot(x,z,pch=19)
par("mar")
par(mar=c(4,4,2,2))
par(mfrow=c(2,2))
plot(x,y)
plot(x,z)
plot(z,x)
plot(y,x)

# another graph male = blue, female = red
x<-  rnorm(100)
y = x+rnorm(100)
g<- gl(2,50)
g<- gl(2,50,labels=c("male","female"))
str(g)
plot(x,y)
plot(x,y,type="n")
par(mfrow=c(1,1))
points(x[g=="male"],y[g=="male"],col="blue")
points(x[g=="female"],y[g=="female"],col="red",pch=19)
