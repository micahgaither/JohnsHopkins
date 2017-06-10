# plot3.r
library("ggplot2")
# Read data 
setwd("C:\\GitHub\\coursera_exploratorydata-2")
NEI <- readRDS("C:\\GitHub\\coursera_exploratorydata-2\\summarySCC_PM25.rds")
SCC <- readRDS("C:\\GitHub\\coursera_exploratorydata-2\\Source_Classification_Code.rds")

# Agg data 
baltimore <- subset(NEI, fips == "24510") 
total.emissions <- aggregate(baltimore[c("Emissions")], list(type = baltimore$type, year = baltimore$year), sum)

# Plot
png('plot3.png', width=480, height=480)
plot3 <- ggplot(total.emissions, aes(x=year, y=Emissions, colour=type)) +
  geom_point(alpha=.2) +
  geom_smooth(alpha=.2, size=1, method="loess") +
  ggtitle("Baltimore Total Emissions by Type")
print(plot3)
dev.off()