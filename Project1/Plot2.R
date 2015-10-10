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

#Make global active power values numeric
subset$Global_active_power <- as.numeric(as.character(subset$Global_active_power))

#Open png device
png(file = "Plot2.png")

#Make line plot
plot(subset$Date,subset$Global_active_power, type= "l", ylab = "Global Active Power (kilowatts)", xlab = "")

#Close the png file device
dev.off()