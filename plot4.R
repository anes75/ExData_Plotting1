Sys.setlocale(locale = 'English')
library(dplyr)

setwd(dirname(rstudioapi::getSourceEditorContext()$path))
d <- read.table('data/household_power_consumption.txt', sep = ';'
                , header = TRUE
                , na.strings = '?'
                , dec = '.')
str(d)
d$Date <- as.Date(d$Date, format = '%d/%m/%Y')
d <- filter(d,Date=='2007-02-01'|Date=='2007-02-02')

d$dateTime <- paste(d$Date,d$Time)
d$dateTime <- strptime(d$dateTime, "%Y-%m-%d %H:%M:%S")

d$Global_active_power <- as.numeric(d$Global_active_power)
d$Sub_metering_1 <- as.numeric(d$Sub_metering_1)
d$Sub_metering_2 <- as.numeric(d$Sub_metering_2)
d$Sub_metering_3 <- as.numeric(d$Sub_metering_3)
d$Voltage <- as.numeric(d$Voltage)
d$Global_reactive_power <- as.numeric(d$Global_reactive_power)

par(mfrow = c(2,2))

plot(d$dateTime,d$Global_active_power, col = 'black'
     , ylab = 'Global Active Power', type = 'l'
     , xlab ='')
plot(d$dateTime,d$Voltage, col = 'black'
     , ylab = 'Voltage', type = 'l'
     , xlab ='datetime')
plot(d$dateTime,d$Sub_metering_1, col = 'black'
     , ylab = 'Energy sub metering', type = 'l'
     , xlab ='')
lines(d$dateTime,d$Sub_metering_2, col = 'red')
lines(d$dateTime,d$Sub_metering_3, col = 'blue')
legend('topright', col = c('black','red','blue'),lwd=c(1,1,1)
       ,c('Sub_metering_1','Sub_metering_2','Sub_metering_3')
       , bty='n'
)
plot(d$dateTime,d$Global_reactive_power, col = 'black'
     , ylab = 'Global_reactive_power', type = 'l'
     , xlab ='datetime'
     )

dev.copy(png,'Plot4.png', height=480,width=480)
dev.off()
par(mfrow = c(1,1))

