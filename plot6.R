## Read in the Data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Load packages
library(ggplot2)
library(dplyr)

## Merge the SCC and NEI datasets by SCC. 
SCC_NEI <- merge(SCC, NEI, by= c("SCC"))

## Subset the SCC_NEI data set to Baltimore City and LA County. The quotes
## are placed around the LA FIPS since R will ignore the leading zero otherwise. 
SCC_NEI_BC_LA <- subset(SCC_NEI, SCC_NEI$fips == 24510|SCC_NEI$fips == "06037")

## Sum up emission amounts by year and by FIPS. 
SCC_NEI_BC_LA_sum <- SCC_NEI_BC_LA %>%
      group_by(year, fips) %>%
      summarize(Emissions = sum(Emissions), na.rm = TRUE)

## Create a plot.
fips_names <- list('06037' = "Los Angeles County", '24510' ="Baltimore City")
fips_labeller <- function(variable,value) {return(fips_names[value])}

png(filename="plot6.png", width=480, height=480)
g <- ggplot(SCC_NEI_BC_LA_sum, aes(year,Emissions))
g <- g + geom_point() + 
         facet_grid(~ fips, labeller = fips_labeller) +
         stat_smooth(method="lm") + 
         ggtitle("PM2.5 Emissions by Year, LA vs Baltimore")
print(g)
dev.off()