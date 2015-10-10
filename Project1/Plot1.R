
#Read dataset
household_data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

#Format Date 
household_data$Date = strptime(household_data$Date, "%d/%m/%Y")
household_data$Date = as.Date(household_data$Date)

#subset for relevant days
subset <- subset(household_data, Date == as.Date("2007-02-01") | Date ==as.Date("2007-02-02"))

#Make values in Global Active Power numeric
subset$Global_active_power <- as.numeric(as.character(subset$Global_active_power))

#Open png device
png(file = "Plot1.png")

#Create histogram 
hist(subset$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")

#Scale y -axis 
yticks <- seq(0, 1200, 200)
axis(2, at = yticks, labels = yticks)

#Close the png file device
dev.off()