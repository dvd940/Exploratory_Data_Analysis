# Plot 5: How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
# Note: for the purpose of this excercise, the data was taken to be any data with "veh" in the Short.name.
#
# This script requires that the following files be in the working directory
# 
# summarySCC_PM25.rds
# Source_Classification_Code.rds
#
# These files can be downloaded from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip
#
# This code requires the following packages:- 
#
# dplyr
# ggplot2
#
# If not already installed, install these using the install.packages function.

# Load libraries
library(dplyr)  # for summarise() and group_by() functions.
library(ggplot2)

# read in the files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


# Extract vehicle sources and merge with NEI data
motor.vehicles <- filter(SCC, grepl('Veh', Short.Name, ignore.case=TRUE))
merged.data <- merge(NEI, motor.vehicles, by='SCC')
motor.vehicles.Baltimore <- filter(merged.data, fips == "24510")

# Plot emissions from motor vehical sources from 1999 to 2008 in Baltimore city.
motor.vehicles.Baltimore.by.year <- summarise(group_by(motor.vehicles.Baltimore, year), sum(Emissions))
names(motor.vehicles.Baltimore.by.year) <- c('year', 'total.emissions')

plot <- ggplot(motor.vehicles.Baltimore.by.year, aes(year, total.emissions) ) 
plot <- plot + geom_line(color = "blue") 
plot <- plot + ggtitle('Emissions from Motor Vehicle Related Sources (Baltimore)')
plot <- plot + xlab("Year") + ylab("Total Emissions (Tons)")
ggsave(filename = "plot5.png", dpi = 96)

# Note: for the purpose of this excercise, the data was taken to be any data with "veh" in the Short.name. 
