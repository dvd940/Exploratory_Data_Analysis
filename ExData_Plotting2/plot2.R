# Plot 2 : Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
# (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot 
# answering this question.
# 
# This script requires that the following files be in the working directory
# 
# summarySCC_PM25.rds
#
# This files can be downloaded from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
#
# This code requires the following packages:- 
# 
# dplyr
#
# If not already installed, install these using the install.packages function.


# Load libraries
library(dplyr)  # for data manipulation functions.

# read in the files
NEI <- readRDS("summarySCC_PM25.rds")

# Filter to show only Baltimore
NEI.Baltimore <- filter(NEI, fips == "24510")

# Group the total PM2.5 emissions by year
NEI.Baltimore.by.year <- summarise(group_by(NEI.Baltimore, year), sum(Emissions))

# Plot the total PM2.5 emission from all sources 
# for each of the years 1999, 2002, 2005, and 2008.
names(NEI.Baltimore.by.year) <- c('year', 'total.pm2.5.emissions')

# Add column for total PM2.5 in thousands.
NEI.Baltimore.by.year <- mutate(NEI.Baltimore.by.year, total.pm2.5.emissions, total.pm2.5.emissions.rounded = round(total.pm2.5.emissions))


# Plot total PM2.5 emissions for each of the years 1999 to 2008.
# & and save to a PNG file.
png('plot2.png', height = 600, width = 800)
par(mgp = c(4, 1, 0), mar = c(8, 5, 4, 2), lwd = 2)

plot(NEI.Baltimore.by.year$year, NEI.Baltimore.by.year$total.pm2.5.emissions.rounded, 
     type="b", 
     main = 'Total PM2.5 emissions (Baltimore City)', 
     xlab = 'Year', 
     ylab = 'Total PM2.5 emissions (tons)', 
     xaxt= "n",
     yaxt = "n"
)

axis(1, at = NEI.Baltimore.by.year$year)
axis(2, at = NEI.Baltimore.by.year$total.pm2.5.emissions.rounded)
mtext(side = 1, "Plot 2: Shows total emissions from PM2.5 decreasing in the Baltimore City, Maryland between 1999 & 2008", line = 6)

dev.off()

