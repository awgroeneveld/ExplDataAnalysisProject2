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
SCC_coal <- subset(SCC, grepl("coal", Short.Name, ignore.case=TRUE))
NEI_coal <- subset(NEI, NEI$SCC %in% SCC_coal$SCC)

# Aggregate by Year and Type
aggregatedTotalCoalByYearAndType <- aggregate(Emissions ~ year+type, NEI_coal, sum)

png("plot4.png",width=640,height=480)
g <- ggplot(aggregatedTotalCoalByYearAndType, aes(x=factor(year), y=Emissions, fill = type))
g <- g + geom_bar(stat="identity") +
  xlab("Years") +
  ylab("Total PM2.5 Emissions") +
  ggtitle("Total Coal Emissions from 1999 to 2008")
print(g)
dev.off()