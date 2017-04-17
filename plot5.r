setwd("/Users/Dylan/Documents/Semester\ 4.2/Data\ Science/ExplData")

inf <- "proj2data.zip"
if (!file.exists(inf)){
    fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
    download.file(fileURL, inf, method="curl")
}  
if (!file.exists("summarySCC_PM25.rds")) { 
    unzip(inf) 
}
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# plot 5 
vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
SCC_vehicles <- SCC[vehicles,]$SCC
NEI_vehicles <- NEI[NEI$SCC %in% SCC_vehicles,]
NEI_baltimoreVehicles <- NEI_vehicles[NEI_vehicles$fips=="24510",]
png("proj2plot5.png",width=480,height=480,units="px",bg="transparent")
library(ggplot2)
plot5 <- ggplot(NEI_baltimoreVehicles,aes(factor(year),Emissions)) +
    geom_bar(stat="identity",fill="grey",width=0.75) +
    theme_bw() +  guides(fill=FALSE) +
    labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
    labs(title=expression("PM"[2.5]*" Emission from Baltimore Motor Vehicle during '98 to '08"))
print(plot5)
dev.off()
