# Objective: Peer-graded Assignment: Course Project 1
# Author: Akbarali Shaikh
# Date: 18-Aug-2019
# plot2.r

plot(finalData$SetTime, finalData$Global_active_power, type="l", 
     col="black", xlab="", ylab="Global Active Power (kilowatts)",
     main="Global Active Power - kilowatts")

dev.copy(png,"plot2.png", width=480, height=480)
dev.off()