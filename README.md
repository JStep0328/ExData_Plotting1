#README
##Initial Instructions
1.  Open RStudio and set working directory
2.  Create a folder in working directory called "data"
3.  Download raw data within the data folder  
    <https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip>
4.  Unzip file within the data folder

##R Scripts : Results
* plot1.R : plot1.png
* plot2.R : plot2.png
* plot3.R : plot3.png
* plot4.R : plot4.png  

NOTE: The png files are within the figure folder in this Repo

##Basis R coding in all four scripts
###Step 1: Read Data
Create raw data  
```
raw <- read.csv2(file = paste0(getwd(), "/data/exdata-data-household_power_consumption/household_power_consumption.txt"), stringsAsFactors = F, na.strings = "?")
```

###Step 2: Subset Data
Requires the `dplyr` R package  
```
require(dplyr)
```  
Filter the raw data to only include 2007-02-01 and 2007-02-02  
```
df <- rbind(filter(raw, Date == "1/2/2007"), filter(raw, Date == "2/2/2007"))
```

###Step 3: Format the Columns within the Subset Data
Change the class of the Date column to Date  
```
df$Date <- as.Date(df$Date , "%d/%m/%Y")
```  
Combine the Date and Time into one string  
```
df$Time <- paste(df$Date, df$Time, sep=" ")
```  
Change the class of the Time column to Date  
```
df$Time <- strptime(df$Time, "%Y-%m-%d %H:%M:%S")
```  
Change the Rest of the columns to numeric  
```
df$Global_active_power <- as.numeric(df$Global_active_power)
df$Global_reactive_power <- as.numeric(df$Global_reactive_power)
df$Voltage <- as.numeric(df$Voltage)
df$Global_intensity <- as.numeric(df$Global_intensity)
df$Sub_metering_1 <- as.numeric(df$Sub_metering_1)
df$Sub_metering_2 <- as.numeric(df$Sub_metering_2)
df$Sub_metering_3 <- as.numeric(df$Sub_metering_3)
```

###plot1.R
Create plot1.png within working directory  
```
png("plot1.png", width = 480, height = 480)
hist(df$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red")
dev.off()
```
![](figure/plot1.png?raw=true)

###plot2.R
```
Create plot2.png within working directory  
png("plot2.png", width = 480, height = 480)
plot(df$Time, df$Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)", type = "l")
dev.off()
```
![](figure/plot2.png?raw=true)

###plot3.R
Create plot3.png within working directory  
```
png("plot3.png", width = 480, height = 480)
ylimits = range(c(df$Sub_metering_1, df$Sub_metering_2, df$Sub_metering_3))
plot(df$Time, df$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "l", ylim = ylimits, col = "black")
par(new = TRUE)
plot(df$Time, df$Sub_metering_2, xlab = "", axes = FALSE, ylab = "", type = "l", ylim = ylimits, col = "red")
par(new = TRUE)
plot(df$Time, df$Sub_metering_3, xlab = "", axes = FALSE, ylab = "", type = "l", ylim = ylimits, col = "blue")
legend("topright",
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = c(1,1,1),
       col = c("black", "red", "blue")
)
dev.off()
```
![](figure/plot3.png?raw=true)

###plot4.R
Create plot4.png within working directory  
```
png("plot4.png", width = 480, height = 480)
par(mfrow = c(2, 2))
with(df, {
    plot(Time, Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
    
    plot(Time, Voltage, xlab = "datetime", type = "l", ylab = "Voltage")
    
    ylimits = range(c(df$Sub_metering_1, df$Sub_metering_2, df$Sub_metering_3))
    plot(Time, Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "l", ylim = ylimits, col = "black")
    
    par(new = TRUE)
    plot(Time, Sub_metering_2, xlab = "", axes = FALSE, ylab = "", type = "l", ylim = ylimits, col = "red")
    par(new = TRUE)
    plot(Time, Sub_metering_3, xlab = "", axes = FALSE, ylab = "", type = "l", ylim = ylimits, col = "blue")
    legend("topright",
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
           bg = "transparent",
           bty = "n",
           lty = c(1,1,1),
           col = c("black", "red", "blue")
    )
    
    plot(Time, Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
    
})
dev.off()
```  
![](figure/plot4.png?raw=true)