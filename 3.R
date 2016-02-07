
# get the zipped data and unzip

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile = "./household_power_consumption.zip")
unzip ("household_power_consumption.zip")

# document the current date

downloadDate <- date()

# upload the data

filename <- "./household_power_consumption.txt"
data <- read.table(filename, header = TRUE, stringsAsFactors=FALSE, sep = ";", na = "?")

# disk size of data

dim(data) # 2075259 9
print(object.size(data), units='auto') 
# View(data)

# select the time window as required

data$Date <- as.Date(data$Date, format="%d/%m/%Y")
data <- subset(data, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

## Converting dates

datetime <- paste(data$Date, data$Time) ; data$Datetime <- as.POSIXct(datetime)

# make the required graph: Global Active Power vs. Day

png(filename = "plot3.png", width = 480, height = 480, units = "px", bg = "white")

with(data, plot(Datetime, Sub_metering_1, type = "l", col = "black", xlab = "", ylab = "Energy sub metering"))

lines(data$Datetime, data$Sub_metering_2, col = "red") 
lines(data$Datetime, data$Sub_metering_3, col = "blue")

legend("topright", col = c("black", "red", "blue"), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd = 1)

# close the device

dev.off()
