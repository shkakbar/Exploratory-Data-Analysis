# Objective: Peer-graded Assignment: Course Project 1
# Author: Akbarali Shaikh
# Date: 18-Aug-2019

# -----------------------------------------------------------------------------
# Preparation, loading  and cleaning data before creatign graphs
# -----------------------------------------------------------------------------
## load file
loadFile <- "household_power_consumption.txt"
## read text file from csv and load in table
plotData <- read.table(loadFile, header=T, sep=";", na.strings="?")
## set time variable
finalData <- plotData[plotData$Date %in% c("1/2/2007","2/2/2007"),]
SetTime <-strptime(paste(finalData$Date, finalData$Time, sep=" "),"%d/%m/%Y %H:%M:%S")
finalData <- cbind(SetTime, finalData)
# -----------------------------------------------------------------------------
## Generating Plot 1
hist(finalData$Global_active_power, col="red", main="Global Active Power", 
     xlab="Global Active Power (kilowatts)")

dev.copy(png,"Global Active Power.png", width=480, height=480)
dev.off()

## Generating Plot 2
plot(finalData$SetTime, finalData$Global_active_power, type="l", 
     col="black", xlab="", ylab="Global Active Power (kilowatts)")

dev.copy(png,"Global Active Power - kilowatts.png", width=480, height=480)
dev.off()

## Generating Plot 3
columnlines <- c("black", "red", "blue")
labels <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
plot(finalData$SetTime, finalData$Sub_metering_1, type="l", 
     col=columnlines[1], xlab="", ylab="Energy sub metering")
lines(finalData$SetTime, finalData$Sub_metering_2, col=columnlines[2])
lines(finalData$SetTime, finalData$Sub_metering_3, col=columnlines[3])
legend("topright", legend=labels, col=columnlines, lty="solid")

dev.copy(png,"local Active Power - Metering.png", width=480, height=480)
dev.off()

## Generating Plot 4
labels <- c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
columnlines <- c("black","red","blue")
par(mfrow=c(2,2))
plot(finalData$SetTime, finalData$Global_active_power, 
     type="l", col="green", xlab="", ylab="Global Active Power")
plot(finalData$SetTime, finalData$Voltage, type="l", col="orange", 
     xlab="datetime", ylab="Voltage")
plot(finalData$SetTime, finalData$Sub_metering_1, type="l", xlab="", 
     ylab="Energy sub metering")
lines(finalData$SetTime, finalData$Sub_metering_2, type="l", col="red")
lines(finalData$SetTime, finalData$Sub_metering_3, type="l", col="blue")
legend("topright", bty="n", legend=labels, lty=1, col=columnlines)
plot(finalData$SetTime, finalData$Global_reactive_power, type="l", 
     col="blue", xlab="datetime", ylab="Global_reactive_power")

dev.copy(png,"Energy sub metering.png", width=480, height=480)
dev.off()