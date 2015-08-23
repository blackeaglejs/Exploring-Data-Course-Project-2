## Read in the Data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Load packages
library(ggplot2)
library(dplyr)

## Merge the SCC and NEI datasets by SCC. 
SCC_NEI <- merge(SCC, NEI, by= c("SCC"))

## Subset the SCC_NEI dataset to only include coal combustion values. 
SCC_NEI_coal <- SCC_NEI[grep("Coal", SCC_NEI$EI.Sector),]

## Sum the total emissions by year. 
SCC_NEI_coal_sum <- SCC_NEI_coal %>%
      group_by(year) %>%
      summarize(Emissions = sum(Emissions), na.rm = TRUE)

## Create a plot. 
png(filename="plot4.png", width = 480, height = 480)
qplot(year, Emissions, data = SCC_NEI_coal_sum, 
      geom = c("point","smooth"),
      main = "Coal Combustion Emissions by Year, 1999-2008")
dev.off()