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

# plot 6
vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
SCC_vehicles <- SCC[vehicles,]$SCC
NEI_vehicles <- NEI[NEI$SCC %in% SCC_vehicles,]
NEI_baltimoreVehicles <- NEI_vehicles[NEI_vehicles$fips=="24510",]
NEI_baltimoreVehicles$city <- "Baltimore City"
NEI_LosAngelesVehicles <- NEI_vehicles[NEI_vehicles$fips=="06037",]
NEI_LosAngelesVehicles$city <- "Los Angeles County"

NEI_LA_and_Baltimore <- rbind(NEI_baltimoreVehicles,NEI_LosAngelesVehicles)
png("proj2plot6.png",width=480,height=480,units="px",bg="transparent")
library(ggplot2)
plot6 <- ggplot(NEI_LA_and_Baltimore , aes(x=factor(year), y=Emissions, fill=city)) +
    geom_bar(aes(fill=year),stat="identity") +
    facet_grid(scales="free", space="free", .~city) +
    guides(fill=FALSE) + theme_bw() +
    labs(x="year", y=expression("Total PM"[2.5]*" Emissions")) + 
    labs(title=expression("PM"[2.5]*" Los Angeles and Baltimore Combined Motor Vehicle missions during '98 to '08"))
print(plot6)
dev.off()
