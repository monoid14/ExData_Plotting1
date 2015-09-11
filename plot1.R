## Plot 1: Histogram of Global Active Power

## load the data
hpc <- read.table(file="household_power_consumption.txt", 
                  header=TRUE, sep=";", quote="", na.strings="?", 
                  stringsAsFactors=FALSE)        #keep date and time as strings

## convert date and time strings to proper class
hpc$Time <- paste(hpc$Date, hpc$Time, sep=" ")
hpc$Time <- strptime(hpc$Time, "%d/%m/%Y %H:%M:%S")
hpc$Date <- as.Date(hpc$Date, "%d/%m/%Y")

## subset to dates indicated
start.date <- as.Date("2007-02-01")
end.date   <- as.Date("2007-02-02")
hpc <- hpc[hpc$Date >= start.date & hpc$Date <= end.date, ]

## draw the plot to PNG file
png("plot1.png", width=480, height=480, units="px")    #specified size 480 X 480
par(bg=NA, cex=1)                   #set background to transparent, fonts normal
hpc <- hpc[!is.na(hpc$Global_active_power), ]          #remove NAs if any
hist(hpc$Global_active_power, col="red", 
     main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()