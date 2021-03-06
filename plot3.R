#Data
raw <- read.csv2(file = paste0(getwd(), "/data/exdata-data-household_power_consumption/household_power_consumption.txt"), stringsAsFactors = F, na.strings = "?")

#Subset Data
require(dplyr)
df <- rbind(filter(raw, Date == "1/2/2007"), filter(raw, Date == "2/2/2007"))

#Define Columns with the Subset Data
df$Date <- as.Date(df$Date , "%d/%m/%Y")
df$Time <- paste(df$Date, df$Time, sep=" ")
df$Time <- strptime(df$Time, "%Y-%m-%d %H:%M:%S")
df$Global_active_power <- as.numeric(df$Global_active_power)
df$Global_reactive_power <- as.numeric(df$Global_reactive_power)
df$Voltage <- as.numeric(df$Voltage)
df$Global_intensity <- as.numeric(df$Global_intensity)
df$Sub_metering_1 <- as.numeric(df$Sub_metering_1)
df$Sub_metering_2 <- as.numeric(df$Sub_metering_2)
df$Sub_metering_3 <- as.numeric(df$Sub_metering_3)

#Plot plot3 to a png file
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