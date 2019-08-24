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
source("plot1.r")

## Generating Plot 2
source("plot2.r")

## Generating Plot 3
source("plot3.r")

## Generating Plot 4
source("plot4.r")

