## Plot 4: Four plots in one picture

## load the data
hpc <- read.table(file="household_power_consumption.txt", 
                  header=TRUE, sep=";", quote="", na.strings="?", 
                  stringsAsFactors=FALSE)    #keep date and time as strings

## convert date and time strings to proper class
hpc$Time <- paste(hpc$Date, hpc$Time, sep=" ")
hpc$Time <- strptime(hpc$Time, "%d/%m/%Y %H:%M:%S")
hpc$Date <- as.Date(hpc$Date, "%d/%m/%Y")

## subset to dates indicated
start.date <- as.Date("2007-02-01")
end.date   <- as.Date("2007-02-02")
hpc <- hpc[hpc$Date >= start.date & hpc$Date <= end.date, ]

## open the PNG file and set up parameters
png("plot4.png", width=480, height=480, units="px")    #specified size 480 X 480
par(mfcol=c(2, 2), bg=NA, cex=0.8)  #set 2X2 plot, background transparent, fonts smaller
loc <- Sys.getlocale(category = "LC_TIME")        #store current locale settings
Sys.setlocale("LC_TIME", "us")  #set the locale to US so that week days appear in English

## plot at position 1,1
data.1.1 <- hpc[!is.na(hpc$Global_active_power), ]     #remove NAs if any
plot(x=data.1.1$Time, y=data.1.1$Global_active_power, type="l", 
     xlab="", ylab="Global Active Power")
data.1.1 <- NULL  #free memory

## plot at position 2,1
data.2.1 <- hpc[!is.na(hpc$Sub_metering_1) & 
                !is.na(hpc$Sub_metering_2) & 
                !is.na(hpc$Sub_metering_3), ]    #remove NAs if any
## select the highest valued param (Sub_metering_1) to set up the axes, then draw lines
with(data.2.1, {
    plot(x=Time, y=Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
    lines(x=Time, y=Sub_metering_1, col="black")
    lines(x=Time, y=Sub_metering_2, col="red")
    lines(x=Time, y=Sub_metering_3, col="blue")
    legend("topright", lty=1, col=c("black", "red", "blue"), bty="n",    #no legend box
           legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
})
data.2.1 <- NULL  #free memory

## plot at position 1, 2
data.1.2 <- hpc[!is.na(hpc$Voltage), ]    #remove NAs if any
plot(x=data.1.2$Time, y=data.1.2$Voltage, type="l", 
     xlab="datetime", ylab="Voltage")
data.1.2 <- NULL  #free memory

## plot at position 2, 2
data.2.2 <- hpc[!is.na(hpc$Global_reactive_power), ]    #remove NAs if any
plot(x=data.2.2$Time, y=data.2.2$Global_reactive_power, type="l", 
     xlab="datetime", ylab="Global_reactive_power")
data.2.2 <- NULL  #free memory

## housekeeping
dev.off()
Sys.setlocale("LC_TIME", loc)  #restore the locale to original