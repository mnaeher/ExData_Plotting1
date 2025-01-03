# Load necessary libraries
library(data.table)

# Read and preprocess data
file_path <- "household_power_consumption.txt"
data <- fread(file_path, na.strings = "?", sep = ";")

# Subset for the required dates
data <- data[Date %in% c("1/2/2007", "2/2/2007")]

# Convert Global_active_power to numeric
data[, Global_active_power := as.numeric(Global_active_power)]

# Create Plot 1
png("plot1.png", width = 480, height = 480)
hist(data$Global_active_power, col = "red", main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency")
dev.off()
