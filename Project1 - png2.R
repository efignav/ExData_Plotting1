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

png("png2.png")

(gap = as.numeric(df$Global_active_power) )

plot(gap, type="l", ylab="Global Active Power (kilowats)", xlab = "", xlim=c(0,2880), xaxt="n")

lablist.x<-as.vector(c("Thu", "Fri", "Sat"))

weekdays(df[1,1],abbreviate = T )
weekdays(df[length(gap),10],abbreviate = T )

axis(side=1, labels = c("Thu","Fri","Sat"), tick =TRUE , at=c(0, length(gap)/2, length(gap)))
dev.off(dev.cur())

