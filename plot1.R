##Plot1. First plot for the assignment of week 1 for the course Exploratory Data Analysis.
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


##Convert Time
##subsetfile$Time <- strptime(subsetfile$Time)
##subsetfile$Time <- format(subsetfile$Time, "%H:%M:%S")


## Numeric values to numeric class
subsetfile$Global_active_power <- as.numeric(subsetfile$Global_active_power, dec = ".")
subsetfile$Global_reactive_power <- as.numeric(subsetfile$Global_reactive_power, dec = ".")
subsetfile$Voltage <- as.numeric(subsetfile$Voltage, dec = ".")
subsetfile$Global_intensity <- as.numeric(subsetfile$Global_intensity, dec = ".")
subsetfile$Sub_metering_1 <- as.numeric(subsetfile$Sub_metering_1, dec = ".")
subsetfile$Sub_metering_2 <- as.numeric(subsetfile$Sub_metering_2, dec = ".")


##setting up png-file
png(filename = "./plot1.png", width = 480, height = 480)


##SPECIFIC FOR PLOT 1
hist(subsetfile$Global_active_power, col = "red", xlab = "Global Active Power (kilowatt)",
     main = "Global Active Power")


##Closing device
dev.off()