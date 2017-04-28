# Assume data files are in working dir
# Since loading takes a while, check if items are already in environment

library(ggplot2)

if(!exists("NEI")){
  NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("Source_Classification_Code.rds")
}

# Create subset for Baltimore 
NEI_baltimore <- subset(NEI, fips=="24510")
# Aggregate by Year and Type
aggregatedBaltimoreByYearAndType <- aggregate(Emissions ~ year+type, NEI_baltimore, sum)

png("plot3.png",width=640,height=480)
g <- ggplot(aggregatedBaltimoreByYearAndType, aes(year, Emissions, color = type))
g <- g + geom_line() +
       xlab("Years") +
       ylab("Total PM2.5 Emissions") +
       ggtitle("Total Emissions in Baltimore City, Maryland from 1999 to 2008")
print(g)
dev.off()