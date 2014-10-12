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
png(filename = "plot4.png", width = 480, height = 480, units = "px")

## first set up the number of graphs to be displated in the plot using mfrow
## mar will create the margins in lines around the plot, botton, left, top, right
## oma will create the margin for text, bottom, left, top, right
par (mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))

with(dat1, {
  ## first graph is line of global active power
  plot(DateTime, Global_active_power, xlab="", ylab="Global Active Power", type="l")
  ## second graph is line of voltage
  plot(DateTime, Voltage, xlab="datetime", ylab="Voltage", type="l")
  ## third graph is 3 line graphs of energy by sub-metering
  plot(DateTime, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
  lines(DateTime, Sub_metering_2, type="l", col="red")
  lines(DateTime, Sub_metering_3, type="l", col="blue")
    ## creates the legend for third grapgh  
    cols = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
    legend("topright", lty=1, lwd=1, col=c("black","blue","red"), legend=cols, bty="n")
  ## forth graph is line of reative power for the dates under analysis
  plot(DateTime, Global_reactive_power, xlab="datetime", ylab="Global_reactive_power", type="l")        
})    
dev.off()

