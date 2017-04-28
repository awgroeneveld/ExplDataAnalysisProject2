# Assume data files are in working dir
# Since loading takes a while, check if items are already in environment
if(!exists("NEI")){
  NEI <- readRDS("summarySCC_PM25.rds")
}
if(!exists("SCC")){
  SCC <- readRDS("Source_Classification_Code.rds")
}

# Question at hand:
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission 
# from all sources for each of the years 1999, 2002, 2005, and 2008.

aggregatedTotalByYear <- aggregate(Emissions ~ year, NEI, sum)

png('plot1.png',width=640,height=480)
barplot(aggregatedTotalByYear$Emissions, names.arg = aggregatedTotalByYear$year,
        xlab="Years", ylab="Total PM2.5 emission",main="Total PM2.5 emissions")
dev.off()
