# setting working directory

myfunction <- function(){
  x <- rnorm(100)
  mean(x)
}

second <- function(x){
  x + rnorm(length(x))
}

# Principles of analytic graphs

library(data.table)
library(tidyverse)

household <- fread("household_power_consumption.txt")
household<- as_tibble(household)
household

household$Date <- dmy(household$Date)
household$Time <- hms(household$Time)
household$Global_active_power <- as.numeric(household$Global_active_power)