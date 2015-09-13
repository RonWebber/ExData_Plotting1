# R script 'plot3.R'

# Step 0: Set up environment.

if (! ('RCurl' %in% rownames(installed.packages()))){
  install.packages('RCurl')
}
library(RCurl)

if(! ('dplyr' %in% rownames(installed.packages()))){
  install.packages('dplyr')
}
library(dplyr)

if(! ('readr' %in% rownames(installed.packages()))) {
  install.packages('readr')
}
library(readr)

# Step 1: Download the data in 'household_power_consumption.zip' and read the data.

url <- 
  'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
download.file(url, destfile = 'household_power_consumption.zip', method = 'libcurl')
date.data.downloaded <- date()
unzip(zipfile = 'household_power_consumption.zip', exdir = './')
data <- read_csv2('./household_power_consumption.txt', col_names = TRUE, na = '?')

# Step 2: Convert Date values and filter the data to the two required dates. 

data$Date <-as.Date(data$Date, format = '%d/%m/%Y')
data <- filter(data, Date == '2007-02-01' | Date == '2007-02-02')

# Step 3: Make 'plot3.R' and 'plot3.png'.

plot(data$Sub_metering_1, xaxt = 'n', type = 'l', xlab = '', 
     ylab = 'Energy sub metering')
xaxt <- 's'
axis(1, at = c(0, nrow(data)/2, nrow(data)), labels = c('Thu', 'Fri', 'Sat'))
lines(data$Sub_metering_2, type = 'l', col = 'red')
lines(data$Sub_metering_3, type = 'l', col = 'blue')
legend('topright', cex = 0.75, 
       legend = c('Sub_metering_1    ', 'Sub_metering_2    ', 'Sub_metering_3    '),
       lty = c(1, 1, 1), col = c('black', 'red', 'blue'))
dev.copy(png, file = 'plot3.png')
dev.off()
