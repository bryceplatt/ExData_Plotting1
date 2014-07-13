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
png('plot2.png',width = 480, height = 480, units = "px")

# Create the plot
plot(d$dateTime,d$Global_active_power,type="l",ylab="Global Active Power (kilowatts)",xlab="")
dev.off()
