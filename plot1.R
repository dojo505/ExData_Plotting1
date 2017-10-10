## script to create first plot for assignment
## output file is a histogram titled plot1.png

## read data
df <- read.table("household_power_consumption.txt", 
            sep = ";", 
            header = TRUE, 
            stringsAsFactors = FALSE,
            na.strings = "?", 
            colClasses = c(rep("character", 2), rep("double", 7)))

## only need data from 2007-02-01 to 2007-02-02
df$Date <- as.Date(df$Date, format = "%d/%m/%Y")
epower <- df[(as.Date("2007-02-01") <= df$Date &
                  df$Date <= as.Date("2007-02-02")),]

## plot
png(file= "plot1.png", height = 480, width = 480)
hist(epower$Global_active_power, 
     breaks = 12, 
     col = "red",
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")
dev.off()
