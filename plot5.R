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

# Aggregate by Year and Type
aggregatedTotalVehicleByYearAndType <- aggregate(Emissions ~ year+type, NEI_vehicle_baltimore, sum)

png("plot5.png",width=640,height=480)
g <- ggplot(aggregatedTotalVehicleByYearAndType, aes(x=factor(year), y=Emissions, fill = type))
g <- g + geom_bar(stat="identity") +
  xlab("Years") +
  ylab("Total PM2.5 Emissions") +
  ggtitle("Total Vehicle Emissions in Baltimore from 1999 to 2008")
print(g)
dev.off()