#####################Plot 5
library("ggplot2")
setwd("C:\\GitHub\\coursera_exploratorydata-2")
NEI <- readRDS("C:\\GitHub\\coursera_exploratorydata-2\\summarySCC_PM25.rds")
SCC <- readRDS("C:\\GitHub\\coursera_exploratorydata-2\\Source_Classification_Code.rds")

# Data
vehicle <- grep("vehicle",SCC$EI.Sector,value=T,ignore.case=T)
SCC.vehicle <- subset(SCC, SCC$EI.Sector %in% vehicle, select=SCC)
BC <- subset(NEI, fips == "24510")
NEI.vehicle<- subset(BC, BC$SCC %in%  SRC.VEH$SCC)
plotdata <- aggregate(NEI.vehicle[c("Emissions")], list(year = NEI.vehicle$year), sum)


# Plot
library(ggplot2)
png('plot5.png', width=480, height=480)
plot(plotdata$year, plotdata$Emissions, type = "l", 
     main = "Baltimore Vehicle Emissions",
     xlab = "Year", ylab = "Emissions")


dev.off()