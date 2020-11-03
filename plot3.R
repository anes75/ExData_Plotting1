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
d$Sub_metering_1 <- as.numeric(d$Sub_metering_1)
d$Sub_metering_2 <- as.numeric(d$Sub_metering_2)
d$Sub_metering_3 <- as.numeric(d$Sub_metering_3)

plot(d$dateTime,d$Sub_metering_1, col = 'black'
     , ylab = 'Energy sub metering', type = 'l'
     , xlab ='')
lines(d$dateTime,d$Sub_metering_2, col = 'red')
lines(d$dateTime,d$Sub_metering_3, col = 'blue')
legend('topright', col = c('black','red','blue'),lwd=c(1,1,1)
       ,c('Sub_metering_1','Sub_metering_2','Sub_metering_3')
       )
dev.copy(png,'Plot3.png', height=480,width=480)
dev.off()

