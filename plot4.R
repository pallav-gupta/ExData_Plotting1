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
hd$datetime <- strptime(hd$datetime ,format = "%d/%m/%Y %H:%M:%S")

hd$Global_active_power <- as.numeric(as.character(hd$Global_active_power))

hd$Sub_metering_1 <- as.numeric(as.character(hd$Sub_metering_1))
hd$Sub_metering_2 <- as.numeric(as.character(hd$Sub_metering_2))
hd$Sub_metering_3 <- as.numeric(as.character(hd$Sub_metering_3))

hd$Global_reactive_power <- as.numeric(as.character(hd$Global_reactive_power))
hd$Voltage <- as.numeric(as.character(hd$Voltage))

par(mfrow=c(2,2))

#plot 1
plot(hd$datetime,hd$Global_active_power , type = "l",xlab = "",ylab = "Global Active Power")

#plot 2
plot(hd$datetime,hd$Voltage , type = "l",xlab = "datetime",ylab = "Voltage")

#plot 3
plot(hd$datetime,hd$Sub_metering_1 , type = "l",xlab = "",ylab = "Energy sub metering" , col = "black")
lines(hd$datetime,hd$Sub_metering_2 , col = "red")
lines(hd$datetime,hd$Sub_metering_3 , col = "blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1","Sub_metering_2", "Sub_metering_3") ,
       lty=c(1,1) , bty = "n" , cex = 0.3)

#plot 4
plot(hd$datetime,hd$Global_reactive_power , type = "l",xlab = "datetime",ylab = "Global_reactive_powe")

dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()



