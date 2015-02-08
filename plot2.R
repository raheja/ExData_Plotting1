## Using sqldf. But this command doesn't take into account that missing values are represented as "?". 
## Since the subsetted dataset doesn't have "?", one can use "sqldf" package for this project. 

# install.package("sqldf")
library(sqldf)
filer <- read.csv.sql(file = "household_power_consumption.txt", sql = "select * from file where (Date == '1/2/2007') OR 
         (Date == '2/2/2007')", header = TRUE, sep = ";")

# convert date
filer$DateTime <- strptime(paste(filer$Date,filer$Time), "%d/%m/%Y %H:%M:%S")

#plot data
with(filer, plot(DateTime, Global_active_power, ylab = "Global Active Power (kilowatts)",xlab = "" , type = "l"))
dev.copy(png, width = 480, height = 480, units = "px", file = "plot2.png")  ## Copy my plot to a PNG file
dev.off()


## The other method is an optimized read.table, that can be used for declaring missing values. 
## One can't select rows. So it reads the entire dataset, -might not be efficient for large datasets.

#  filer <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", stringsAsFactors = FALSE)
#  filer <- na.omit(filer)
#  filer <- filer[filer$Date %in% c("1/2/2007", "2/2/2007"),]
