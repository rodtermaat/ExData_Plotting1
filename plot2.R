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
png(filename = "plot2.png", width = 480, height = 480, units = "px")

## use the plot funtion with data time on the x axis and global active power on the y
## set as line graph
plot(dat1$DateTime, 
     dat1$Global_active_power, 
     type="l", 
     xlab="", 
     ylab="Global Active Power (kilowatts)")
dev.off()