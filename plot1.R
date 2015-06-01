# Produce exploratory plots using the Individual household electric power
# consumption data set

# Plot 1: A histogram of global active power consumption

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

# Create a PNG device
png("plot1.png")

# Plot the histogram as shown in the assignment.
with(pow, 
     hist(Global_active_power, 
          col="red", 
          main="Global Active Power", 
          xlab="Global Active Power (kilowatts)"))

# Close the PNG file
dev.off()

