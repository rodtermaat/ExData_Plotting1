## this code assumes that you have downloaded and extracted the date to the 
## working directory in R

install.packages("dplyr", dependencies=TRUE)
library(dplyr)

## read in the data file and assign data types to various columns
dat <- read.table("./household_power_consumption.txt",
                  header=T, 
                  sep=';',
                  na.strings="?",
                  colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))

## using the dplyr package and filter function subset the data set to only
## the days needed for the analysis
dat1 <- filter(dat, Date=='1/2/2007' | Date=='2/2/2007')

## cast the character date/time to actual date/time
dat1$DateTime <- strptime(paste(dat1$Date, dat1$Time), "%d/%m/%Y %H:%M:%S")

## used to created png file for assignment
  png(filename = "plot3.png", width = 480, height = 480, units = "px")

## this plot will examine the 3 sub metering columns.  It will create
## 1 plot with 3 line graphs for the days on the x axis and the
## energy on the y axis
  plot(dat1$DateTime, dat1$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
  lines(dat1$DateTime, dat1$Sub_metering_2, type="l", col="red")
  lines(dat1$DateTime, dat1$Sub_metering_3, type="l", col="blue")

## this sets up the legend on the top right by first defineing the items in cols
  cols = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
  legend("topright", lty=1, lwd=1, col=c("black","blue","red"), legend=cols)
  dev.off()



