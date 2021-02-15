rm(list=ls())
data=read.table("household_power_consumption.txt", header = T, sep = ";", check.names = T)
head(data)
str(data)

data$Date = as.Date(data$Date, "%d/%m/%Y") # format must mirror the structure of the field
df = subset(x = data, subset = (Date>= as.Date("2007-02-01") &  Date<= as.Date("2007-02-02")) )
str(df)

(df$DateTime <- paste(df$Date, df$Time) )
str(df)

(df$DateTime= strptime(df$DateTime , "%Y-%m-%d %H:%M:%S", tz = "GMT"))
str(df)

png("png1.png")

hist(as.numeric(df$Global_active_power) , col="red", main="Global Active Power", 
     xlab="Global Active Power (kilowats)")

png("png1.png")
hist(as.numeric(df$Global_active_power) , col="red", main="Global Active Power", 
     xlab="Global Active Power (kilowats)")
dev.off(dev.cur())

