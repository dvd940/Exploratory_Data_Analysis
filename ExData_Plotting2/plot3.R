# plot3. Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) 
# variable, which of these four sources have seen decreases in emissions from 1999–2008 
# for Baltimore City? Which have seen increases in emissions from 1999–2008? 
# Use the ggplot2 plotting system to make a plot answer this question.
#
# This script requires that the following files be in the working directory
# 
# summarySCC_PM25.rds
#
# This file can be downloaded from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip

# This code requires the following packages:- 
# 
# dplyr
# ggplot2
# RColorBrewer
#
# If not already installed, install these using the install.packages function.


# Load libraries
library(dplyr)  # for data manipulaton functions.
library(ggplot2)  # for plotting
library(RColorBrewer) # For color palette 

# read in the file
NEI <- readRDS("summarySCC_PM25.rds")

# Filter to show only Baltimore
NEI.Baltimore <- filter(NEI, fips == "24510")

# Group the total PM2.5 emissions by year
NEI.Baltimore.by.year <- summarise(group_by(NEI.Baltimore, year, type), sum(Emissions))

# Plot the total PM2.5 emission from all sources by type. 
names(NEI.Baltimore.by.year) <- c('year', 'type', 'total.emissions')

plot <- ggplot(NEI.Baltimore.by.year, aes(year, total.emissions, color = type) ) 
plot <- plot + geom_line() + ggtitle('Total PM2.5 Emissions by Type - Baltimore City')
plot <- plot + xlab("Year") + ylab("Total Emissions (Tons)")
plot <- plot + theme(legend.position=c(0.85, 0.85)) 
plot <- plot + theme(legend.background=element_rect(fill="white", colour="black"))
plot <- plot + labs(color = "Type")
plot <- plot + scale_color_brewer(palette="Dark2")

ggsave(filename = "plot3.png", dpi = 96)