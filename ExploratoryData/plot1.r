#plot1.r
# read data
setwd("C:\\GitHub\\coursera_exploratorydata-2")
NEI <- readRDS("C:\\GitHub\\coursera_exploratorydata-2\\summarySCC_PM25.rds")
SCC <- readRDS("C:\\GitHub\\coursera_exploratorydata-2\\Source_Classification_Code.rds")
# subset Emissions and year from NEI and sum values
agg.totals<-aggregate(Emissions ~ year,NEI, sum)
# plot1
png('plot1.png', width=480, height=480)
plot(agg.totals$year, agg.totals$Emissions, type = "l", main = "PM2.5 Total Emissions", xlab = "Year", ylab = "Emissions")
dev.off()