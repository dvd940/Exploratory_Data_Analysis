# Load libraries
library('dplyr')  # for data manipulation functions

# Read data from the source dataset file
# dataset file is expected to be in the same folder as this script file.
data <- read.table('household_power_consumption.txt', header=TRUE, sep=';', colClasses = c("character", "character", rep("numeric",7)), na.strings="?")

# Filter the dates we want (2007-02-01 and 2007-02-02)
filtered.data <- filter(data, Date == '1/2/2007' | Date == '2/2/2007')  # filter function is from dplyr library

# Convert dates and times to Date/Time variables.
filtered.data$Time <- strptime(paste(filtered.data$Date, filtered.data$Time), "%d/%m/%Y %H:%M:%S")
filtered.data$Date <- as.Date(filtered.data$Date, "%d/%m/%Y")

# A note on transparency: To make a transparent PNG, add the parameter 'bg = "transparent"' to 
# the png command. 

#plot histogram
png('plot1.png', height = 480, width = 480)
plot.data = filtered.data$Global_active_power
hist(plot.data, col='red', main='Global Active Power', xlab='Global Active Power (kilowatts)', ylab='Frequency')
dev.off()