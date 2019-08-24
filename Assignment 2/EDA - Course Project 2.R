#--------------------------------------------
# Name: Akbarali Shaikh
# Date: 18-Aug-2019
# Exploratory Data Analysis - Course Project 2
# Introduction:
# Fine particulate matter (PM2.5) is an ambient air pollutant for which there is strong evidence that it is harmful to human health. In the United States, the Environmental Protection Agency (EPA) is tasked with setting national ambient air quality standards for fine PM and for tracking the emissions of this pollutant into the atmosphere. Approximatly every 3 years, the EPA releases its database on emissions of PM2.5. This database is known as the National Emissions Inventory (NEI). You can read more information about the NEI at the EPA National Emissions Inventory web site.
# For each year and for each type of PM source, the NEI records how many tons of PM2.5 were emitted from that source over the course of the entire year. The data that you will use for this assignment are for 1999, 2002, 2005, and 2008.
#--------------------------------------------

# Load Library
library(ggplot2)
library(plyr)

# Load NEI and SCC data frames from the .rds files.

NEI <- readRDS("NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("NEI_data/Source_Classification_Code.rds")

# Viewdata
head(NEI)
head(SCC)

# Further Pre-processing of the data is done.
lToFactor <- c("year", "type", "Pollutant","SCC","fips")
NEI[,colToFactor] <- lapply(NEI[,colToFactor], factor)

head(levels(NEI$fips))

## The levels have NA as "   NA", so converting that level back to NA
levels(NEI$fips)[1] = NA
NEIdata<-NEI[complete.cases(NEI),]
colSums(is.na(NEIdata))


# Question 1
# Have total emissions from PM2.5 decreased in the 
  # United States from 1999 to 2008? Using the base 
  # plotting system, make a plot showing the total PM2.5 
  # emission from all sources for each of the years 1999, 
  # 2002, 2005, and 2008:

totalEmission <- aggregate(Emissions ~ year, NEIdata, sum)
totalEmission

barplot(
  (totalEmission$Emissions)/10^6,
  names.arg=totalEmission$year,
  xlab="Year",
  ylab="PM2.5 Emissions (10^6 Tons)",
  main="Total PM2.5 Emissions From All US Sources"
)

dev.copy(png,"Q1. Total PM2.5 Emissions From All US Sources.png", width=480, height=480)
dev.off()

# Question 2:
# Have total emissions from PM2.5 decreased 
  #in the Baltimore City, Maryland (fips == “24510”)
  # from 1999 to 2008? Use the base plotting system 
  # to make a plot answering this question.

NEIdataBaltimore<-subset(NEIdata, fips == "24510")
totalEmissionBaltimore <- aggregate(Emissions ~ year, NEIdataBaltimore, sum)
totalEmissionBaltimore

barplot(
  (totalEmissionBaltimore$Emissions)/10^6,
  names.arg=totalEmissionBaltimore$year,
  xlab="Year",
  ylab="PM2.5 Emissions (10^6 Tons)",
  main="Total PM2.5 Emissions From All Baltimore City Sources"
)

dev.copy(png,"Q2. Total PM2.5 Emissions From All Baltimore City Sources.png", width=480, height=480)
dev.off()

# Question 3:
# Of the four types of sources indicated by the type 
  # (point, nonpoint, onroad, nonroad) variable, 
  # which of these four sources have seen decreases 
  # in emissions from 1999-2008 for Baltimore City? 
  # Which have seen increases in emissions from 1999-2008? 
  # Use the ggplot2 plotting system to make a plot answer 
  # this question.

g<-ggplot(aes(x = year, y = Emissions, fill=type), data=NEIdataBaltimore)
g+geom_bar(stat="identity")+
  facet_grid(.~type)+
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
  labs(title=expression("PM"[2.5]*" Emissions, Baltimore City 1999-2008 by Source Type"))+
  guides(fill=FALSE)

dev.copy(png,"Q3. PM2.5 Emissions, Baltimore City 1999-2008 by Source Type.png", width=480, height=480)
dev.off()

# Question 4: 
# Across the United States, how have emissions from 
  # coal combustion-related sources changed from 1999-2008?

## making the names in the SCC dataframe pretty by removing \\. in all the names
names(SCC)<-gsub("\\.","", names(SCC))
SCCcombustion<-grepl(pattern = "comb", SCC$SCCLevelOne, ignore.case = TRUE)
SCCCoal<-grepl(pattern = "coal", SCC$SCCLevelFour, ignore.case = TRUE)

## extracting the SCC in 
SCCCoalCombustionSCC<-SCC[SCCcombustion & SCCCoal,]$SCC
NIECoalCombustionValues<-NEIdata[NEIdata$SCC %in% SCCCoalCombustionSCC,]
NIECoalCombustionTotalEm<-aggregate(Emissions~year, NIECoalCombustionValues, sum)

g<-ggplot(aes(year, Emissions/10^5), data=NIECoalCombustionTotalEm)
g+geom_bar(stat="identity",fill="grey",width=0.75) +
  guides(fill=FALSE) +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
  labs(title=expression("PM"[2.5]*" Coal Combustion Source Emissions Across US from 1999-2008"))

dev.copy(png,"Q4. PM2.5, Coal Combustion Source Emissions Across US from 1999-2008.png", width=480, height=480)
dev.off()

# Question 5: 
# How have emissions from motor vehicle sources 
  # changed from 1999-2008 in Baltimore City?

SCCvehicle<-grepl(pattern = "vehicle", SCC$EISector, ignore.case = TRUE)
SCCvehicleSCC <- SCC[SCCvehicle,]$SCC

## using this boolean vector get the interested rows from the baltimore data
NEIvehicleSSC <- NEIdata[NEIdata$SCC %in% SCCvehicleSCC, ]
NEIvehicleBaltimore <- subset(NEIvehicleSSC, fips == "24510")
NIEvehicleBaltimoreTotEm<-aggregate(Emissions~year, NEIvehicleBaltimore, sum)

g<-ggplot(aes(year, Emissions/10^5), data=NIEvehicleBaltimoreTotEm)
g+geom_bar(stat="identity",fill="grey",width=0.75) +
  guides(fill=FALSE) +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
  labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore from 1999-2008"))

dev.copy(png,"Q5. PM2.5, Motor Vehicle Source Emissions in Baltimore from 1999-2008.png", width=480, height=480)
dev.off()

# Question 6
# Compare emissions from motor vehicle sources 
  # in Baltimore City with emissions from motor 
  # vehicle sources in Los Angeles County, California 
  # (fips == “06037”). Which city has seen greater changes 
  # over time in motor vehicle emissions?

NEIvehicleBalti<-subset(NEIvehicleSSC, fips == "24510")
NEIvehicleBalti$city <- "Baltimore City"
NEIvehiclela<-subset(NEIvehicleSSC, fips == "06037")
NEIvehiclela$city <- "Los Angeles County"
NEIBothCity <- rbind(NEIvehicleBalti, NEIvehiclela)

ggplot(NEIBothCity, aes(x=year, y=Emissions, fill=city)) +
  geom_bar(aes(fill=year),stat="identity") +
  facet_grid(.~city) +
  guides(fill=FALSE) + theme_bw() +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (Kilo-Tons)")) + 
  labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore & LA, 1999-2008"))

dev.copy(png,"Q6. PM2.5, Motor Vehicle Source Emissions in Baltimore & LA, 1999-2008.png", width=480, height=480)
dev.off()

aggregateEmissions <- aggregate(Emissions~city+year, data=NEIBothCity, sum)
aggregate(Emissions~city, data=aggregateEmissions, range)


  
  


















