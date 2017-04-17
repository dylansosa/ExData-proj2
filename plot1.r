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

# plot 1
png("proj2plot1.png",width=480,height=480,units="px",bg="transparent")
totalEmissions <- aggregate(Emissions ~ year,NEI, sum)
barplot(
    (totalEmissions$Emissions)/10^6,
    names.arg=totalEmissions$year,
    xlab="Year",
    ylab="PM2.5 Emissions",
    main="Total U.S. PM2.5 Emissions"
)
# Emissions have decresaed from '98 to '08
dev.off()
