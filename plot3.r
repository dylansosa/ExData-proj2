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

# plot 3 
png("proj2plot3.png",width=480,height=480,units="px",bg="transparent")
library(ggplot2)
plot3 <- ggplot(NEI_baltimore,aes(factor(year),Emissions,fill=type)) +
    geom_bar(stat="identity") +
    theme_bw() + guides(fill=FALSE)+
    facet_grid(.~type,scales = "free",space="free") + 
    labs(x="year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
    labs(title=expression("PM"[2.5]*" Emissions for Baltimore During 1999-2008"))
print(plot3)
