# Loads the data frame that all plots will be created from.
# Assumes that the file "household_power_consumption.txt" exists in the working folder.
# Instead of loading all 2,075,259 rows and filtering later, only the 2880 required rows are loaded.
# Column classes are set to Date, POSIXlt and numeric as needed.
loadData <- function() {

  data <- read.table(file = "household_power_consumption.txt", header = F, sep = ";", colClasses = "character", nrows = 2880, comment.char = "#", skip = 66637, stringsAsFactors = F)
  
  colnames(data) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
  data$Time <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
  data$Date <- as.Date(data$Date, "%d/%m/%Y")
  data$Global_active_power <- as.numeric(data$Global_active_power)
  data$Global_reactive_power <- as.numeric(data$Global_reactive_power)
  data$Voltage <- as.numeric(data$Voltage)
  data$Global_intensity <- as.numeric(data$Global_intensity)
  data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
  data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
  data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)
  
  return(data)
}

# Builds the plot and stores it as a PNG file in the working folder
buildPlot <- function(data) {
  png(file = "plot3.png")
  
  plot(data$Time, data$Sub_metering_1, type = "n", main = "", xlab = "", ylab = "Energy sub metering")
  lines(data$Time, data$Sub_metering_1, col = rgb(12, 12, 12, maxColorValue = 255))
  lines(data$Time, data$Sub_metering_2, col = rgb(255, 37, 0, maxColorValue = 255))
  lines(data$Time, data$Sub_metering_3, col = rgb(4, 51, 255, maxColorValue = 255))
  legend("topright", lwd = 1, col = c(rgb(12, 12, 12, maxColorValue = 255), rgb(255, 37, 0, maxColorValue = 255), rgb(4, 51, 255, maxColorValue = 255)), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  dev.off()
}

data <- loadData()

buildPlot(data)

