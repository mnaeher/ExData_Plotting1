# Load necessary libraries
library(data.table)

# Read and preprocess data
file_path <- "household_power_consumption.txt"
data <- fread(file_path, na.strings = "?", sep = ";")

# Subset for the required dates
data <- data[Date %in% c("1/2/2007", "2/2/2007")]

# Combine Date and Time and convert to datetime
data[, datetime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Convert variables to numeric
data[, `:=`(Global_active_power = as.numeric(Global_active_power),
            Voltage = as.numeric(Voltage),
            Sub_metering_1 = as.numeric(Sub_metering_1),
            Sub_metering_2 = as.numeric(Sub_metering_2),
            Sub_metering_3 = as.numeric(Sub_metering_3),
            Global_reactive_power = as.numeric(Global_reactive_power))]

# Create Plot 4
png("plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))

# Top-left
plot(data$datetime, data$Global_active_power, type = "l", xlab = "", 
     ylab = "Global Active Power")

# Top-right
plot(data$datetime, data$Voltage, type = "l", xlab = "datetime", 
     ylab = "Voltage")

# Bottom-left
plot(data$datetime, data$Sub_metering_1, type = "l", xlab = "", 
     ylab = "Energy sub metering")
lines(data$datetime, data$Sub_metering_2, col = "red")
lines(data$datetime, data$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col = c("black", "red", "blue"), lty = 1, bty = "n")

# Bottom-right
plot(data$datetime, data$Global_reactive_power, type = "l", xlab = "datetime", 
     ylab = "Global Reactive Power")
dev.off()
