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

# plot 2
NEI_baltimore <- NEI[NEI$fips=="24510",]
totalEmissions_Baltimore <- aggregate(Emissions ~ year, NEI_baltimore,sum)
png("proj2plot2.png",width=480,height=480,units="px",bg="transparent")
barplot(
    totalEmissions_Baltimore$Emissions,
    names.arg=totalEmissions_Baltimore$year,
    xlab="Year",
    ylab="PM2.5 Emissions",
    main="Total Baltimore PM2.5 Emissions"
)
dev.off()
