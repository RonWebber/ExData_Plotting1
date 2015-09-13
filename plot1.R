# R script is 'plot1.R'

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
data <- read_csv2('./household_power_consumption.txt', na = '?')

# Step 2: Filter the data to the two required dates. 

data$Date <-as.Date(data$Date, format = '%d/%m/%Y')
data <- filter(data, Date == '2007-02-01' | Date == '2007-02-02')

# Step 3: Make 'plot1' and 'plot1.png'.

hist(as.numeric(data$Global_active_power), col = 'red', 
     main = 'Global Active Power', xlab = 'Global Active Power (kilowatts)')
dev.copy(png, file = 'plot1.png')
dev.off()
