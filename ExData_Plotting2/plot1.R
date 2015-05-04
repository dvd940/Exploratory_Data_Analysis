# Plot 1 : Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from all sources 
# for each of the years 1999, 2002, 2005, and 2008.

# This script requires that the following files be in the working directory
# 
# summarySCC_PM25.rds
#
# This file can be downloaded from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
#
# This code requires the following packages:- 
# 
# dplyr
#
# If not already installed, install these using the install.packages function.

# Load libraries
library(dplyr)  # for summarise() and group_by() functions.

# read in the files
NEI <- readRDS("summarySCC_PM25.rds")

# Group the total PM2.5 emissions by year
NEI.by.year <- summarise(group_by(NEI, year), sum(Emissions))

# Plot the total PM2.5 emission from all sources 
# for each of the years 1999, 2002, 2005, and 2008.
names(NEI.by.year) <- c('year', 'total.pm2.5.emissions')

# Add column for total PM2.5 in thousands.
NEI.by.year <- mutate(NEI.by.year, total.pm2.5.emissions, total.pm2.5.emissions.thousands = floor(total.pm2.5.emissions/1000))

# Plot total PM2.5 emissions for each of the years 1999, 2002, 2005, and 2008.
# & save to a PNG file.
png('plot1.png', height = 600, width = 800)
par(mgp = c(4, 1, 0), mar = c(8, 5, 4, 2), lwd = 2)
plot(NEI.by.year$year, NEI.by.year$total.pm2.5.emissions.thousands, 
     type="b", 
     main = 'Total PM2.5 emissions (United States)', 
     xlab = 'Year', 
     ylab = 'Total PM2.5 emissions (tons in thousands)', 
     xaxt= "n",
     yaxt = "n"
)

axis(1, at = NEI.by.year$Year)
axis(2, at = NEI.by.year$total.pm2.5.emissions.thousands, las = 2)
mtext(side = 1, "Plot 1: Shows how total emissions from PM2.5 decreased in the United States from 1999 to 2008", line = 6)
dev.off()


