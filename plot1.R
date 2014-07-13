# Read data into a dataframe
temp <- tempfile()
download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.table(unz(temp, "household_power_consumption.txt"),header = T,sep = ';',na.strings = "?")
unlink(temp)

# Filter out the two relevant days
d <- subset(data, Date=='1/2/2007' | Date=='2/2/2007')

# Open the png device
png('plot1.png',width = 480, height = 480, units = "px")

# Create the histogram
hist(d$Global_active_power,xlab = "Global Active Power (kilowatts)",freq = T,main = "Global Active Power",col="red")
dev.off()