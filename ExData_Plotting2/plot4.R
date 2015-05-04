# plot 4 : Across the United States, how have emissions from coal 
# combustion-related sources changed from 1999–2008?
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
#
# If not already installed, install these using the install.packages function.



# Load libraries
library(dplyr)  # for data manipulaton functions.
library(ggplot2)  # for plotting
library(RColorBrewer) # For color palette 

# read in the files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Extract coal combustion related sources and merge with NEI data
comb.coal <- filter(SCC, grepl('*Comb(.)*Coal*', Short.Name, ignore.case=TRUE))
merged.data <- merge(NEI, comb.coal, by='SCC')

# Plot total emissions From Coal Combustion Related Sources & save to PNG file
emissions <- summarise(group_by(merged.data, year), sum(Emissions))
names(emissions) <- c('year', 'total.emissions')

plot <- ggplot(emissions, aes(year, total.emissions) ) 
plot <- plot + geom_line(color = "blue") 
plot <- plot + ggtitle('Emissions From Coal Combustion Related Sources (United States)')
plot <- plot + xlab("Year") + ylab("Total Emissions (Tons)")

ggsave(filename = "plot4.png", dpi = 96)