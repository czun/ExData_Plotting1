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

#Make sub-metering 1 and 2; global active power; global active power; and voltage values numeric
subset$Sub_metering_1 <- as.numeric(as.character(subset$Sub_metering_1))
subset$Sub_metering_2 <- as.numeric(as.character(subset$Sub_metering_2))
subset$Global_active_power <- as.numeric(as.character(subset$Global_active_power))
subset$Voltage <- as.numeric(as.character(subset$Voltage))
subset$Global_reactive_power <- as.numeric(as.character(subset$Global_reactive_power))

#Open png device
png(file = "Plot4.png")

#Make Plot
  #Create 2 rows and 2 columns
   par(mfrow = c(2, 2))
   with(subset, {
     plot(subset$Date,subset$Global_active_power, type= "l", ylab = "Global Active Power", xlab = "")
     plot(subset$Date,subset$Voltage, type= "l", ylab = "Voltage", xlab = "datetime")
     plot(subset$Date, subset$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
          lines(subset$Date, subset$Sub_metering_2, col = "red", type = "l")
          lines(subset$Date, subset$Sub_metering_3, col = "blue", type = "l")
          legend("topright", lty = 1, bty ="n", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
     plot(subset$Date, subset$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime" )
   })

#Close the png file device
dev.off()





