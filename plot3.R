## script to create third plot for assignment
## output file is plot3.png

## read data
df <- read.table("household_power_consumption.txt", 
                 sep = ";", 
                 header = TRUE, 
                 stringsAsFactors = FALSE,
                 na.strings = "?", 
                 colClasses = c(rep("character", 2), rep("double", 7)))

## only need data from 2007-02-01 to 2007-02-02
df$Date <- as.Date(df$Date, format = "%d/%m/%Y")
df$Time <- strptime(paste(df$Date, df$Time), format = "%Y-%m-%d %H:%M:%S")
epower <- df[(as.Date("2007-02-01") <= df$Date &
                  df$Date <= as.Date("2007-02-02")),]

## epower$mins is a new column which is the time in minutes
## from the first data point at 00:00 midnight to the 
## current data point. 48 hours is 2880 minutes
epower$mins <- difftime(epower$Time, epower$Time[1], units = "mins")

## make plot in png format
png(filename = "plot3.png", height = 480, width = 480)
plot(epower$mins, epower$Sub_metering_1, type = "l", xlab = "", 
     xaxt = "n", ylab = "Energy sub metering")
lines(epower$mins, epower$Sub_metering_2, type = "l", col = "red")
lines(epower$mins, epower$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = colnames(epower)[7:9], 
       lty = c(1,1,1), col = c("black", "red", "blue"))
axis(side = 1, at = c(0, 1440, 2880), labels = c("Thu", "Fri", "Sat"))
dev.off()
