#####################Plot 4
library("ggplot2")
setwd("C:\\GitHub\\coursera_exploratorydata-2")
NEI <- readRDS("C:\\GitHub\\coursera_exploratorydata-2\\summarySCC_PM25.rds")
SRC <- readRDS("C:\\GitHub\\coursera_exploratorydata-2\\Source_Classification_Code.rds")

#  Create Data
CC <- grep("coal",SRC$EI.Sector,value=T,ignore.case=T)
SRC.CC <- subset(SRC, SRC$EI.Sector %in% CC, select=SCC)
NEI.CC <- subset(NEI, NEI$SCC %in%  SRC.CC$SCC)
pd <- aggregate(NEI.CC[c("Emissions")], list(year = NEI.CC$year), sum)

#  Create Plot
png('plot4.png', width=480, height=480)
plot4 <- ggplot(pd, aes(x=year, y=Emissions)) +
  geom_point(alpha=.3) +
  geom_smooth(alpha=.2, size=1) +
  ggtitle("US Coal Combustion Emissions")
print(plot4)


dev.off()
