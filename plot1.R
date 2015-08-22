## Read in the Data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Subset the data by year into separate datasets. 
NEI_1999 <- subset(NEI,NEI$year == 1999)
NEI_2002 <- subset(NEI, NEI$year == 2002)
NEI_2005 <- subset(NEI, NEI$year == 2005)
NEI_2008 <- subset(NEI, NEI$year == 2008)

## Calculate the sum of the emissions for each year. 
emissions_1999 <- sum(NEI_1999$Emissions)
emissions_2002 <- sum(NEI_2002$Emissions)
emissions_2005 <- sum(NEI_2005$Emissions)
emissions_2008 <- sum(NEI_2008$Emissions)

## Turn these into a dataframe. 
emissions <- c(emissions_1999,emissions_2002,emissions_2005,emissions_2008)
years <- c("1999","2002","2005","2008")
NEI_final <- data.frame(years,emissions)

## Create a plot. 
png(filename="plot1.png", width = 480, height = 480)
with(NEI_final, plot(years, emissions,
                     xlab = "Year",
                     ylab = "Emissions",
                     main = "Total PM2.5 Emissions by Year"))
dev.off()