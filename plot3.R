## Plot 3: Energy per day

## load the data
hpc <- read.table(file="household_power_consumption.txt", 
                  header=TRUE, sep=";", quote="", na.strings="?", 
                  stringsAsFactors=FALSE)  #keep date and time as strings

## convert date and time strings to proper class
hpc$Time <- paste(hpc$Date, hpc$Time, sep=" ")
hpc$Time <- strptime(hpc$Time, "%d/%m/%Y %H:%M:%S")
hpc$Date <- as.Date(hpc$Date, "%d/%m/%Y")

## subset to dates indicated
start.date <- as.Date("2007-02-01")
end.date   <- as.Date("2007-02-02")
hpc <- hpc[hpc$Date >= start.date & hpc$Date <= end.date, ]

## draw the plot to PNG file
png("plot3.png", width=480, height=480, units="px")  #specified size 480 X 480
par(bg=NA, cex=1)                 #set background to transparent, fonts normal
loc <- Sys.getlocale(category = "LC_TIME")      #store current locale settings
Sys.setlocale("LC_TIME", "us")  #set the locale to US so that week days appear in English

## select the highest valued param (Sub_metering_1) to set up the axes, then draw lines
hpc <- hpc[!is.na(hpc$Sub_metering_1) & 
           !is.na(hpc$Sub_metering_2) & 
           !is.na(hpc$Sub_metering_3), ]    #remove NAs if any
with(hpc, {
    plot(x=Time, y=Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
    lines(x=Time, y=Sub_metering_1, col="black")
    lines(x=Time, y=Sub_metering_2, col="red")
    lines(x=Time, y=Sub_metering_3, col="blue")
    legend("topright", lty=1, col=c("black", "red", "blue"), 
           legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
})

## housekeeping
dev.off()
Sys.setlocale("LC_TIME", loc)  #restore the locale to original