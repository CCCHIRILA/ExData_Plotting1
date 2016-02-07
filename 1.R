
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

# make the graph 1 required

hist(data$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

## Saving to file
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()