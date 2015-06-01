# Produce exploratory plots using the Individual household electric power
# consumption data set

# Plot 4: Several plots

# We are going to read in only some of the lines of the large file to save time
# and memory, so set up the column names explicitly here rather than reading
# them out of the file
names <- c("Date", 
           "Time", 
           "Global_active_power", 
           "Global_reactive_power", 
           "Voltage", 
           "Global_intensity", 
           "Sub_metering_1", 
           "Sub_metering_2", 
           "Sub_metering_3")

# Read the data. I have chosen to use the unz function to read directly from
# the zip file. To this I apply read.delim using ";" as separator, and skip and
# nrows to select only the desired dates and times.
pow <- read.delim(unz("exdata-data-household_power_consumption.zip",
                      "household_power_consumption.txt"), 
                  sep=";", 
                  header=F, 
                  skip=66637, 
                  nrows=2880, 
                  col.names=names)

# Plots will work better if we use native R datetime classes rather than
# character vectors, so convert. First join the Date and Time columns, then use
# strptime to extract the fields into a new field of class POSIXlt.
pow$Date.Time <- strptime(paste(pow$Date, pow$Time), 
                          format="%d/%m/%Y %H:%M:%S")

# Create a PNG device
png("plot4.png")

par(mfcol=c(2, 2))

# Upper left: line plot of global active power over time
with(pow, 
     plot(Date.Time, 
          Global_active_power, 
          type='l', 
          xlab="", 
          ylab="Global Active Power"))

# Lower left: composite line chart of sub metering data
with(pow, {
    # Set up the plot and labels but don't plot data yet
    plot(Date.Time, Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")

    # Add the three series, one at a time
    points(Date.Time, Sub_metering_1, type="l", col="black")
    points(Date.Time, Sub_metering_2, type="l", col="red")
    points(Date.Time, Sub_metering_3, type="l", col="blue")

    # Add the legend
    legend("topright", 
           lty=1, 
           bty="n",
           col=c("black", "red", "blue"), 
           legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
})

# Upper right: line chart of Voltage over time
with(pow,
    plot(Date.Time, Voltage, type="l", xlab="datetime"))

# Lower right: line chart of Global reactive power over time
with(pow,
    plot(Date.Time, Global_reactive_power, type="l", xlab="datetime"))

# Close the PNG file
dev.off()

