# Assume data files are in working dir
# Since loading takes a while, check if items are already in environment

library(ggplot2)

if(!exists("NEI")){
  NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("Source_Classification_Code.rds")
}

# Create subset for Coal 
SCC_vehicle <- subset(SCC, grepl("vehicle", EI.Sector, ignore.case=TRUE))
NEI_vehicle_baltimore <- subset(NEI, fips=="24510"  & SCC %in% SCC_vehicle$SCC)
NEI_vehicle_lacounty <- subset(NEI, fips=="06037"  & SCC %in% SCC_vehicle$SCC)


# Aggregate by Year and Type
aggregatedTotalVehicleBaltimoreByYear <- aggregate(Emissions ~ year, NEI_vehicle_baltimore, sum)
aggregatedTotalVehicleLaCountyByYear <- aggregate(Emissions ~ year, NEI_vehicle_lacounty, sum)

# Define the scale factor using 1999 as a base
maxBaltimore<-aggregatedTotalVehicleBaltimoreByYear[aggregatedTotalVehicleBaltimoreByYear$year==1999,2];
maxLaCounty<-aggregatedTotalVehicleLaCountyByYear[aggregatedTotalVehicleLaCountyByYear$year==1999,2];

# Scale the data
scaledBaltimore<-data.frame(year=aggregatedTotalVehicleBaltimoreByYear$year,
                            region=rep("Baltimore",4),
                            Emissions=aggregatedTotalVehicleBaltimoreByYear$Emissions/maxBaltimore)
scaledLaCounty<-data.frame(year=aggregatedTotalVehicleLaCountyByYear$year,
                           region=rep("LA County",4),
                           Emissions=aggregatedTotalVehicleLaCountyByYear$Emissions/maxLaCounty)

# Concatenate the data frames
allScaled<-rbind(scaledBaltimore,scaledLaCounty)
  
png("plot6.png",width=640,height=480)
g <- ggplot(allScaled, aes(x=factor(year), y=Emissions, fill = region))
g <- g + geom_bar(stat="identity",position="dodge") +
  xlab("Years") +
  ylab("Total PM2.5 Emissions Relative to 1999") +
  ggtitle("Total Vehicle Emissions Relative to 1999 in Baltimore and Los Angeles County from 1999 to 2008")
print(g)
dev.off()