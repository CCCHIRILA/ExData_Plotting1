
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

# make the required graph

png(filename = "plot4.png", width = 480, height = 480, units = "px", bg = "transparent")

par(mfrow=c(2,2))

with(data, {
        
        plot(Global_active_power ~ Datetime, type="l", ylab="Global Active Power (kilowatts)", xlab="")
        
        plot(Voltage ~ Datetime, type="l", ylab="Voltage (volt)", xlab="datetime")
        
        plot(Sub_metering_1 ~ Datetime, type="l", ylab="Energy sub mettering", xlab="")
        lines(Sub_metering_2 ~ Datetime,col='Red')
        lines(Sub_metering_3 ~ Datetime,col='Blue')
        
        legend("topright", col = c("black", "red", "blue"), lty=1, bty="n",
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        
        plot(Global_reactive_power ~ Datetime, type="l", ylab="Global_reactive_power (kilowatts)", xlab="datetime")
})

## Saving to file

dev.off()

