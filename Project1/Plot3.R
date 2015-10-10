#Read dataset
household_data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

#Format Date
household_data$Date = strptime(household_data$Date, "%d/%m/%Y")
household_data$Date = as.Date(household_data$Date)

#Subset for relevant days
subset <- subset(household_data, Date == as.Date("2007-02-01") | Date ==as.Date("2007-02-02"))

#Merge Time values into Date Column
subset$Date <- paste(subset$Date, subset$Time)
subset[, "Date"] <- subset$Date
subset$Date = strptime(subset$Date, "%Y-%m-%d %H:%M:%S")

#Make sub-metering 1 and 2 numeric
subset$Sub_metering_1 <- as.numeric(as.character(subset$Sub_metering_1))
subset$Sub_metering_2 <- as.numeric(as.character(subset$Sub_metering_2))

#Open png device
png(file = "Plot3.png")

#Make line plot
plot(subset$Date, subset$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")

  #Add data for other two sub_metering values
  lines(subset$Date, subset3$Sub_metering_2, col = "red", type = "l")
  lines(subset$Date, subset3$Sub_metering_3, col = "blue", type = "l")

  #Make Legend
  legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#Close the png file device
dev.off()
