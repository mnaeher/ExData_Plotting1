# Load the necessary library
library(data.table)

# Read the data from the file and handle missing values ("?")
data <- fread("household_power_consumption.txt", na.strings = "?")

# Check if the file was successfully loaded
if (nrow(data) == 0) {
  stop("The file could not be loaded or is empty.")
}

# Combine the Date and Time columns into a new column called "datetime"
data[, datetime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Convert relevant columns to numeric
data[, `:=`(
  Sub_metering_1 = as.numeric(Sub_metering_1),
  Sub_metering_2 = as.numeric(Sub_metering_2),
  Sub_metering_3 = as.numeric(Sub_metering_3)
)]

# Filter the data for the period from February 1, 2007, to February 2, 2007
filtered_data <- data[(datetime >= "2007-02-01") & (datetime < "2007-02-03")]

# Check if there is any data after filtering
if (nrow(filtered_data) == 0) {
  stop("No data found!")
}

# Create Plot 3
png("plot3.png", width = 480, height = 480)
plot(filtered_data$datetime, filtered_data$Sub_metering_1, type = "l", xlab = "", 
     ylab = "Energy sub metering")
lines(filtered_data$datetime, filtered_data$Sub_metering_2, col = "red")
lines(filtered_data$datetime, filtered_data$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty = 1)
dev.off()
