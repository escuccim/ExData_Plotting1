## File plot3.R
## By Eric Scuccimarra (skooch@gmail.com)
## 2017-12-20
## Reads data in from file, subsets it, and creates plot

# Read the data if it doesn't already exist so we can avoid having to repeatedly read in this huge file 
if(!exists("power_data")){
    power_data <- read.table("../data/household_power_consumption.txt", sep=";", na.strings="?", header=TRUE)    
    
    # Filter out the dates we want
    power_data <- subset(power_data, power_data$Date %in% c("1/2/2007", "2/2/2007"))
    
    # Combine the date and time into single field
    power_data$DateTime <- strptime(paste(power_data$Date, power_data$Time, sep=" "), format="%d/%m/%Y %H:%M:%S")
    
    # Convert date and time columns to dates and times
    power_data$Date <- as.Date(power_data$Date, '%d/%m/%Y')
}

png(filename="plot3.png",width=480,height=480)
plot(power_data$DateTime, power_data$Sub_metering_1, col="black", type="l", xlab="", ylab="Energy sub metering")
lines(power_data$DateTime, power_data$Sub_metering_2, col="red", type="l")
lines(power_data$DateTime, power_data$Sub_metering_3, col="blue", type="l")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=c(1,1,1))
dev.off()