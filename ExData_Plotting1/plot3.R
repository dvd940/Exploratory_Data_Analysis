# Load libraries
library('dplyr')  # for data manipulation functions

# Read data from the source dataset file
# dataset file is expected to be in the same folder as this script file.
data <- read.table('household_power_consumption.txt', header=TRUE, sep=';', colClasses = c("character", "character", rep("numeric",7)), na.strings="?")

# Filter the dates we want (2007-02-01 and 2007-02-02)
filtered.data <- filter(data, Date == '1/2/2007' | Date == '2/2/2007')  # filter function is from dplyr library

# Convert dates and times to Date/Time variables.
filtered.data$Date <- as.Date(filtered.data$Date, "%d/%m/%Y")

# Create a new feature for DateTime
filtered.data$DateTime <- as.POSIXct(paste(filtered.data$Date, filtered.data$Time))

# A note on transparency: To make a transparent PNG, add the parameter 'bg = "transparent"' to 
# the png command.

# Plot chart to PNG file
png('plot3.png', height = 480, width = 480)
plot(filtered.data$Sub_metering_1 ~ filtered.data$DateTime, type='l', ylab="Energy sub metering", xlab="")
lines(filtered.data$Sub_metering_2 ~ filtered.data$DateTime, col='red')
lines(filtered.data$Sub_metering_3 ~ filtered.data$DateTime, col='blue')
legend("topright", lty = 1, col = c('black', 'blue','red'), legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'))
dev.off()