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
png('plot3.png',width = 480, height = 480, units = "px")

# Create the plot
plot(d$dateTime,d$Sub_metering_1,type="l",ylab="Energy sub metering",col="black",xlab="")
lines(d$dateTime,d$Sub_metering_2,type="l",col="red")
lines(d$dateTime,d$Sub_metering_3,type="l",col="blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))
dev.off()