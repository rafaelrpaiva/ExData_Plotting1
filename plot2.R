## 
# Source code for creating the household active power timeline 
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
png(file="plot2.png", width=480, height=480)

# Step 5: Creating the plot using line and closing the device.
Sys.setlocale("LC_TIME", "English") # to show data in English, following the course pattern

plot(sample_data$Date_Time, as.numeric(sample_data$Global_active_power), type="l", xlab="",
     ylab = "Global Active Power (kilowatts)")

dev.off()