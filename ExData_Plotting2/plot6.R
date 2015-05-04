# Plot 6: Compare emissions from motor vehicle sources in Baltimore City with emissions 
# from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
# Which city has seen greater changes over time in motor vehicle emissions?
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
# RColorBrewer
# grid
#
# If not already installed, install these using the install.packages function.

# Load libraries
library(dplyr)  # for data manipulation functions.
library(ggplot2)  # for plotting
library(RColorBrewer) # For color palette 
library(grid)  # for arrow

# read in the files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Extract vehicle sources and merge with NEI data
motor.vehicles <- filter(SCC, grepl('Veh', Short.Name, ignore.case=TRUE))
merged.data <- merge(NEI, motor.vehicles, by='SCC')
motor.vehicles.emissions <- filter(merged.data, fips == "24510" | fips == "06037")


motor.vehicles.emissions.by.year <- summarise(group_by(motor.vehicles.emissions, year, fips), sum(Emissions))
motor.vehicles.emissions.by.year$city <- ifelse(motor.vehicles.emissions.by.year$fips == "24510", "Baltimore City", "LA County" )
names(motor.vehicles.emissions.by.year) <- c('year', 'fips', 'total.emissions', "location")

# Plot emissions from motor vehicle sources in Baltimore City &  Los Angeles County, California
plot <- ggplot(motor.vehicles.emissions.by.year, aes(year, total.emissions, color = location) ) 
plot <- plot + geom_line() + ggtitle('Emissions from Motor Vehicle Related Sources') 
plot <- plot + xlab("Year") + ylab("Total Emissions (Tons)")
plot <- plot + theme(legend.background=element_rect(fill="white", colour="black"))
plot <- plot + labs(color = "Location")
plot <- plot + scale_color_brewer(palette="Set1", limits=c("LA County", "Baltimore City"))

# Add annotations to the plot with information about changes over time.
plot <- plot + annotate("text", x = 2004, y = 3250, label = "Increase of 163.5 tons in 2008 compared to 1999", color = "darkgrey")
plot <- plot + annotate("segment", x = 2007, xend = 2007.5, y = 3500, yend = 4000, color = "red", aplha = 0.5, size = 1, arrow = arrow())
plot <- plot + annotate("text", x = 2004, y = 1500, label = "Decease of 258.5 tons in 2008 compared to 1999", color = "darkgrey")
plot <- plot + annotate("segment", x = 2007, xend = 2007.8, y = 1250, yend = 350, color = "blue" , aplha = 0.5, size = 1, arrow = arrow())

ggsave(filename = "plot6.png", dpi = 96)
