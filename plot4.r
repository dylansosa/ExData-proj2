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

# plot4
combustion <- grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE)
coal <- grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE) 
combust_coal <- (combustion & coal)
SCC_combustion <- SCC[combust_coal,]$SCC
NEI_combustion <- NEI[NEI$SCC %in% SCC_combustion,]

png("proj2plot4.png",width=480,height=480,units="px",bg="transparent")
library(ggplot2)
plot4 <- ggplot(NEI_combustion,aes(factor(year),Emissions/10^6)) +
    geom_bar(stat="identity",fill="grey",width=0.75) +
    theme_bw() +  guides(fill=FALSE) +
    labs(x="year", y=expression("Total PM"[2.5]*" Emissions")) + 
    labs(title=expression("PM"[2.5]*" U.S. Coal Combustion Emissions from '98 to '08"))
print(plot4)
dev.off()
