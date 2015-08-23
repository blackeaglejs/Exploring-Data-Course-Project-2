## Read in the Data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Subset the data into JUST Baltimore City, MD.
NEI_BC <- subset(NEI, NEI$fips == 24510)

## Load packages.
library(ggplot2)
library (dplyr)

## Sum variables using dplyr. 
NEI_BC_sum <- NEI_BC %>%
      group_by(year,type) %>%
      summarize(Emissions = sum(Emissions), na.rm = TRUE)

## Plot the variables.
png(filename="plot3.png", width = 960, height = 480)
qplot(year, Emissions, data = NEI_BC_sum, 
      facets = . ~ type, 
      geom = c("point","smooth"),
      main = "Emissions by Year and Type, Baltimore City")
dev.off()