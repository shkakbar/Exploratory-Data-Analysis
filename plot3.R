# Objective: Peer-graded Assignment: Course Project 1
# Author: Akbarali Shaikh
# Date: 18-Aug-2019
# plot3.r

columnlines <- c("black", "red", "blue")
labels <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
plot(finalData$SetTime, finalData$Sub_metering_1, type="l", 
     col=columnlines[1], xlab="", ylab="Energy sub metering",
     main="Global Active Power - Metering")
lines(finalData$SetTime, finalData$Sub_metering_2, col=columnlines[2])
lines(finalData$SetTime, finalData$Sub_metering_3, col=columnlines[3])
legend("topright", legend=labels, col=columnlines, lty="solid")

dev.copy(png,"plot3.png", width=480, height=480)
dev.off()