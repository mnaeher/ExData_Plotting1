# Load the necessary library
library(data.table)


# Read the data from the file and handle missing values ("?")
data <- fread("household_power_consumption.txt", na.strings = "?")

# Check if the file was successfully loaded
if (nrow(data) == 0) {
  stop("The file could not be loaded or is empty.")
}

# Combine the Date and Time columns into a new column called "dateTime"
data[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Convert the "Global_active_power" column to numeric
data[, Global_active_power := as.numeric(Global_active_power)]

# Filter the data for the period from February 1, 2007, to February 2, 2007
filtered_data <- data[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

# Check if there is any data after filtering
if (nrow(filtered_data) == 0) {
  stop("No data found")
}

# Save the plot as a PNG file
png("plot2.png", width = 480, height = 480)

# Create the plot
plot(
  x = filtered_data[, dateTime], 
  y = filtered_data[, Global_active_power], 
  type = "l", 
  xlab = "", 
  ylab = "Global Active Power (kilowatts)"
)

# Close the PNG file to save it
dev.off()

