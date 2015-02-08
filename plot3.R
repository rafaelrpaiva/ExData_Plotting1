## 
# Source code for creating graphics showing the 3 sub meterings 
# during the 2-day period.  
# Data range used: February 1st and February 2nd, 2007
# Coursera discipline: Exploratory Data Analysis, 2015

library(data.table)
options(warn=-1) # Used for removing fread warnings
# Step 1: Reading whole data using fread
data <- fread("household_power_consumption.txt", sep=";", header=TRUE, na.strings = "?")
# Step 2: Adding a new column pasting Date and Time information first defined as character
data <- cbind(data, strptime(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S"))
colnames(data)[10] <- "Date_Time"

start_date <- strptime("01/02/2007 00:00:00", format="%d/%m/%Y %H:%M:%S")
end_date <- strptime("03/02/2007 00:00:00", format="%d/%m/%Y %H:%M:%S")

# Step 3: filtering dates defined above
sample_data <- data[(data$Date_Time >= start_date & data$Date_Time < end_date), ]

# Step 4: opening the PNG file that will be saved
png(file="plot3.png", width=480, height=480)

# Step 5: Creating the plot using lines, colors defined and closing the device.
Sys.setlocale("LC_TIME", "English") # to show data in English, following the course pattern

plot(sample_data$Date_Time, as.numeric(sample_data$Sub_metering_1), type="l", xlab="",
     ylab = "Energy sub metering")
lines(sample_data$Date_Time, as.numeric(sample_data$Sub_metering_2), type="l", col="red")
lines(sample_data$Date_Time, as.numeric(sample_data$Sub_metering_3), type="l", col="blue")

legend("topright", col = c("black","blue", "red"), lty=1, legend = colnames(sample_data)[7:9])

dev.off()