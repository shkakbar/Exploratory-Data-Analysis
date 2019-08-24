# Objective: Peer-graded Assignment: Course Project 1
# Author: Akbarali Shaikh
# Date: 18-Aug-2019
# plot4.r

labels <- c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
columnlines <- c("black","red","blue")
par(mfrow=c(2,2))
plot(finalData$SetTime, finalData$Global_active_power, 
     type="l", col="green", xlab="", ylab="Global Active Power",
     main="Energy sub metering")
plot(finalData$SetTime, finalData$Voltage, type="l", col="orange", 
     xlab="datetime", ylab="Voltage",
     main="Energy sub metering")
plot(finalData$SetTime, finalData$Sub_metering_1, type="l", xlab="", 
     ylab="Energy sub metering",
     main="Energy sub metering")
lines(finalData$SetTime, finalData$Sub_metering_2, type="l", col="red")
lines(finalData$SetTime, finalData$Sub_metering_3, type="l", col="blue")
legend("topright", bty="n", legend=labels, lty=1, col=columnlines)
plot(finalData$SetTime, finalData$Global_reactive_power, type="l", 
     col="blue", xlab="datetime", ylab="Global_reactive_power",
     main="Energy sub metering")

dev.copy(png,"plot4.png", width=480, height=480)
dev.off()