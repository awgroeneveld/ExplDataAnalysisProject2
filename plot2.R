# Assume data files are in working dir
# Since loading takes a while, check if items are already in environment
if(!exists("NEI")){
  NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("Source_Classification_Code.rds")
}

# Question at hand:
# Have total emissions from PM2.5 decreased in 
# the Baltimore City, Maryland (𝚏𝚒𝚙𝚜 == "𝟸𝟺𝟻𝟷𝟶") from 1999 
# to 2008? Use the base plotting system to make a plot answering this question.

NEI_baltimore <- subset(NEI, fips=="24510")
aggregatedTotalByYear <- aggregate(Emissions ~ year, NEI_baltimore, sum)

png('plot2.png',width=640,height=480)
barplot(aggregatedTotalByYear$Emissions, names.arg = aggregatedTotalByYear$year,
        xlab="Years", ylab="Total PM2.5 emission",main="Total PM2.5 emissions for Baltimore")
dev.off()
