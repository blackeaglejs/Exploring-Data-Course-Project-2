## Read in the Data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Subset the data into JUST Baltimore City, MD.
NEI_BC <- subset(NEI, NEI$fips == 24510)

## Subset the data by year into separate datasets. 
NEI_BC_1999 <- subset(NEI_BC,NEI_BC$year == 1999)
NEI_BC_2002 <- subset(NEI_BC, NEI_BC$year == 2002)
NEI_BC_2005 <- subset(NEI_BC, NEI_BC$year == 2005)
NEI_BC_2008 <- subset(NEI_BC, NEI_BC$year == 2008)

## Calculate the sum of the emissions for each year. 
emissions_BC_1999 <- sum(NEI_BC_1999$Emissions)
emissions_BC_2002 <- sum(NEI_BC_2002$Emissions)
emissions_BC_2005 <- sum(NEI_BC_2005$Emissions)
emissions_BC_2008 <- sum(NEI_BC_2008$Emissions)

## Turn these into a dataframe. 
emissions_BC <- c(emissions_BC_1999,emissions_BC_2002,emissions_BC_2005,emissions_BC_2008)
years <- c("1999","2002","2005","2008")
NEI_BC_final <- data.frame(years,emissions_BC)

## Create a plot. 
png(filename="plot2.png", width = 480, height = 480)
with(NEI_BC_final, plot(years, emissions_BC,
                     xlab = "Year",
                     ylab = "Emissions",
                     main = "Total PM2.5 Emissions by Year, Baltimore City"))
dev.off()