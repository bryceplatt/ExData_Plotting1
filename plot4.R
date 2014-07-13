# Read data into a dataframe
temp <- tempfile()
download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.table(unz(temp, "household_power_consumption.txt"),header = T,sep = ';',na.strings = "?")
unlink(temp)

# Filter out the two relevant days
d <- subset(data, Date=='1/2/2007' | Date=='2/2/2007')

# Format the date and add as a column
dateTime <- strptime(paste(d$Date,d$Time), format="%d/%m/%Y %H:%M:%S")
d <- cbind(dateTime,d)

# Open the png device
png('plot4.png',width = 480, height = 480, units = "px")

# Create the plot
par(mfcol = c(2,2))
plot(d$dateTime,d$Global_active_power,type="l",ylab="Global Active Power",xlab="")
plot(d$dateTime,d$Sub_metering_1,type="l",ylab="Energy sub metering",col="black",xlab="")
lines(d$dateTime,d$Sub_metering_2,type="l",col="red")
lines(d$dateTime,d$Sub_metering_3,type="l",col="blue")
#bty = "n" is to get rid of the boarder around the legend
legend("topright",bty = "n" ,lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))
plot(d$dateTime,d$Voltage,type="l",xlab = "datetime",ylab = "Voltage")
plot(d$dateTime,d$Global_reactive_power,xlab = "datetime",ylab = "Global_reactive_power",type = "l")

# Finally, export the graph to png
dev.off()