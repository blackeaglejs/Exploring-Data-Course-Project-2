## Download the data
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl,destfile="particulate_data.zip", method="curl")

## Unzip the data.
filename <- "particulate_data.zip"
unzip(filename)