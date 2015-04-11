# Incude required Packages 
library(dplyr)

filename <- "exdata-data-household_power_consumption.zip"
if(!file.exists("household_power_consumption.txt")) {
        download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",filename)
        unzip(filename) 
}

hd <- read.table("household_power_consumption.txt",header = T,sep = ";") %>% 
        tbl_df() %>% filter(Date == '1/2/2007' | Date =='2/2/2007') %>%
        mutate(datetime = paste(as.character(Date),as.character(Time)))


hd$Date <- as.Date(hd$Date,format = "%d/%m/%Y")
hd$Time <- strptime(hd$datetime ,format = "%d/%m/%Y %H:%M:%S")

hd$Global_active_power <- as.numeric(as.character(hd$Global_active_power))

hist(hd$Global_active_power,xlab = "Global Active Power(kilowatts)",main ="Global Active Power",col = "red")
dev.copy(png, file="plot1.png", width=480, height=480)
dev.off()