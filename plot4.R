##Plot4. Fourth plot for the assignment of week 1 for the course Exploratory Data Analysis.
##This is part of the Data Scientist specialisation of the John Hopkins University.

##GENERIC FOR ALL PLOTS - getting the data set properly

##Load the relevant libraries
library(plyr)
library(dplyr)
library(lubridate)
library(readr)
library(data.table)

##Read the data file
energyusagefile <- "./household_power_consumption.txt"
energyusage <- fread(energyusagefile, header = TRUE, sep = ";", stringsAsFactors = FALSE)

##Convert date from character to Date
energyusage$Date <- as.Date(energyusage$Date, format = "%d/%m/%Y")


##Select relevant rows
subsetfile <- filter(energyusage, Date == "2007-02-01" | Date == "2007-02-02")


## Numeric values to numeric class
subsetfile$Global_active_power <- as.numeric(subsetfile$Global_active_power, dec = ".")
subsetfile$Global_reactive_power <- as.numeric(subsetfile$Global_reactive_power, dec = ".")
subsetfile$Voltage <- as.numeric(subsetfile$Voltage, dec = ".")
subsetfile$Global_intensity <- as.numeric(subsetfile$Global_intensity, dec = ".")
subsetfile$Sub_metering_1 <- as.numeric(subsetfile$Sub_metering_1, dec = ".")
subsetfile$Sub_metering_2 <- as.numeric(subsetfile$Sub_metering_2, dec = ".")


##setting up png-file
png(filename = "./plot4.png", width = 480, height = 480)

##Set up the panel
par(mfcol = c(2,2))


##FIRST PLOT (= Plot2)
with(subsetfile, plot(Global_active_power, type = "l", axes=FALSE, frame.plot=TRUE, 
                      xlab = "", ylab = "Global Active Power (kilowatt)"))
axis(side = 1, at = c(0, 1440, 2880), labels = c("Thu", "Fri", "Sat"))
axis(side = 2, at = c(0,2,4,6), labels = c("0", "2", "4", "6"))


##SECOND PLIT (= Plot 3)
with(subsetfile, plot(Sub_metering_1, type = "l", col = "black", axes=FALSE, frame.plot=TRUE, 
                      xlab = "", ylab = "Energy sub metering"))
with(subsetfile, points(Sub_metering_2, type = "l", col = "red"))
with(subsetfile, points(Sub_metering_3, type = "l", col = "blue"))
axis(side = 1, at = c(0, 1440, 2880), labels = c("Thu", "Fri", "Sat"))
axis(side = 2, at = c(0,10,20,30), labels = c("0", "10", "20", "30"))
legend("topright", lty = 1 , col = c("black", "red", "blue"), 
       legend =c( "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


##THIRD PLOT
with(subsetfile, plot(Voltage, type = "l", col = "black", axes=FALSE, frame.plot=TRUE, 
                      xlab = "datetime", ylab = "Voltage"))
axis(side = 1, at = c(0, 1440, 2880), labels = c("Thu", "Fri", "Sat"))
axis(side = 2, ylim = range(subsetfile$Voltage))

##FOURTH PLOT
with(subsetfile, plot(Global_reactive_power, type = "l", col = "black", axes=FALSE, frame.plot=TRUE, xlab = "datetime"))
axis(side = 1, at = c(0, 1440, 2880), labels = c("Thu", "Fri", "Sat"))
axis(side = 2, ylim = range(subsetfile$Global_reactive_power))

##Closing device
dev.off()