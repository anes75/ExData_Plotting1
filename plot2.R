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

plot(d$dateTime,d$Global_active_power, col = 'black'
     , ylab = 'Global Active Power (kilowatts)', type = 'l'
     , xlab ='')
dev.copy(png,'Plot2.png',width=480, height=480)
dev.off()

