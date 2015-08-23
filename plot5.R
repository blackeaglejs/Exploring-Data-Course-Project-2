## Read in the Data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Load packages
library(ggplot2)
library(dplyr)

## Merge the SCC and NEI datasets by SCC. 
SCC_NEI <- merge(SCC, NEI, by= c("SCC"))

## Subset the SCC_NEI data set to Baltimore City.
SCC_NEI_BC <- subset(SCC_NEI, SCC_NEI$fips == 24510)

## Subset down to motor vehicles. 
SCC_NEI_BC_MV <- SCC_NEI_BC[grep("Vehicles",SCC_NEI_BC$EI.Sector),]

## Sum the total emissions by year. 
SCC_NEI_BC_MV_sum <- SCC_NEI_BC_MV %>%
      group_by(year) %>%
      summarize(Emissions = sum(Emissions), na.rm = TRUE)

## Create a plot.
png("plot5.png", width=480, height=480)
qplot(year, Emissions, data = SCC_NEI_BC_MV_sum, 
      geom = c("point","smooth"),
      main = "Emissions by year for Vehicles in Baltimore City")
dev.off()