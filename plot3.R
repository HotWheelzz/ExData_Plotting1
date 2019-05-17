#For code to run data need to be on working directory named as "household_power_consumption.txt".
#Read data into variable
HPConsumption <- read.table("household_power_consumption.txt", header=TRUE, 
                            sep=";", na.strings = "?", 
                            colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

#Date to Type Date
HPConsumption$Date <- as.Date(HPConsumption$Date, "%d/%m/%Y")

#Creates subtes of data with date rangefrom Feb. 1, 2007 to Feb. 2, 2007
HPConsumption <- subset(HPConsumption,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

#Remove incomplete observation
HPConsumption <- HPConsumption[complete.cases(HPConsumption),]

#Combnes date and time, creates a vector the removes the column
dateTime <- paste(HPConsumption$Date, HPConsumption$Time)
dateTime <- setNames(dateTime, "DateTime")
HPConsumption <- HPConsumption[ ,!(names(HPConsumption) %in% c("Date","Time"))]

#Add DateTime column and formats
HPConsumption <- cbind(dateTime, HPConsumption)
HPConsumption$dateTime <- as.POSIXct(dateTime)

#Creates plot3
with(HPConsumption, {
        plot(Sub_metering_1~dateTime, type="l",
             ylab="Global Active Power (kilowatts)", xlab="")
        lines(Sub_metering_2~dateTime,col='Red')
        lines(Sub_metering_3~dateTime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
