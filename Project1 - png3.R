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

png("png3.png")

plot(df$Sub_metering_1, type="l", ylab="Energy sub metering", ylim=c(0,38), xlab = "", xlim=c(0,2880), xaxt="n")
par(new=T)
plot(df$Sub_metering_2, type="l", ylab="Energy sub metering", ylim=c(0,38), col="red", xlab = "", xlim=c(0,2880), xaxt="n")
par(new=T)
plot(df$Sub_metering_3, type="l", ylab="Energy sub metering", ylim=c(0,38), col="blue", xlab = "", xlim=c(0,2880), xaxt="n")
par(new=T)
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"), lty=1:3, cex=0.8)

lablist.x<-as.vector(c("Thu", "Fri", "Sat"))

weekdays(df[1,1],abbreviate = T )
weekdays(df[length(df$Sub_metering_1),10],abbreviate = T )

axis(side=1, labels = c("Thu","Fri","Sat"), tick =TRUE , at=c(0, length(df$Sub_metering_1)/2, length(df$Sub_metering_1)), cex.axis=0.8)
dev.off(dev.cur())

