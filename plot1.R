# Objective: Peer-graded Assignment: Course Project 1
# Author: Akbarali Shaikh
# Date: 18-Aug-2019
# plot1.r

hist(finalData$Global_active_power, col="red", main="Global Active Power", 
     xlab="Global Active Power (kilowatts)")

dev.copy(png,"plot1.png", width=480, height=480)
dev.off()