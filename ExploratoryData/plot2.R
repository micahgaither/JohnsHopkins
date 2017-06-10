# plot2.r
# read data 
setwd("C:\\GitHub\\coursera_exploratorydata-2")
NEI <- readRDS("C:\\GitHub\\coursera_exploratorydata-2\\summarySCC_PM25.rds")
SCC <- readRDS("C:\\GitHub\\coursera_exploratorydata-2\\Source_Classification_Code.rds")


#Subset and aggregate 
baltimore <- subset(NEI, fips == "24510")
total.emissions <- aggregate(baltimore[c("Emissions")], list(year = baltimore$year), sum)

# plot 2
png('plot2.png', width=480, height=480)
plot(total.emissions$year, total.emissions$Emissions, type = "l", main = "Total Emissions for Baltimore", xlab = "Year", ylab = "Emissions")
dev.off()