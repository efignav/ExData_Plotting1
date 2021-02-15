rm(lis=ls())
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

png("png4.png")

par(mfrow=c(1,1))
par(mfrow=c(2,2))

# 1
(gap = as.numeric(df$Global_active_power) )
plot(gap, type="l", ylab="Global Active Power", xlab = "", xlim=c(0,2880)
     , xaxt="n", cex.axis=0.8)

lablist.x<-as.vector(c("Thu", "Fri", "Sat"))
weekdays(df[1,1],abbreviate = T )
weekdays(df[length(gap),10],abbreviate = T )
axis(side=1, labels = c("Thu","Fri","Sat"), tick =TRUE , at=c(0, length(gap)/2, length(gap)),
     cex.axis=0.8)

#-----------------------------------------------------------
# 2
plot(df$Voltage, type="l", ylab="Voltage", xlab = "datetime", ylim=c(234, 246)
     , xaxt="n", yaxt="n")
lablist.x<-as.vector(c("Thu", "Fri", "Sat"))
weekdays(df[1,1],abbreviate = T )
weekdays(df[length(gap),10],abbreviate = T )
axis(side=1, labels = c("Thu","Fri","Sat"), tick =TRUE , at=c(0, length(gap)/2, length(gap)), 
     cex.axis=0.8)
axis(side=2, labels = c(234, "", 238,"", 242,"", 246), tick =TRUE , 
     at= c(234, 236, 238, 240, 242, 244, 246), cex.axis=0.8)

#-----------------------------------------------------------
# 3
plot(df$Sub_metering_1, type="l", ylab="Energy sub metering", ylim=c(0,38), 
     xlab = "", xlim=c(0,2880), xaxt="n", cex.axis=0.8)
par(new=T)
plot(df$Sub_metering_2, type="l", ylab="Energy sub metering", ylim=c(0,38), col="red", 
     xlab = "", xlim=c(0,2880), xaxt="n", cex.axis=0.8)
par(new=T)
plot(df$Sub_metering_3, type="l", ylab="Energy sub metering", ylim=c(0,38), col="blue", 
     xlab = "", xlim=c(0,2880), xaxt="n", cex.axis=0.8)
par(new=T)
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"), lty=1:3, cex=0.8)

lablist.x<-as.vector(c("Thu", "Fri", "Sat"))
weekdays(df[1,1],abbreviate = T )
weekdays(df[length(gap),10],abbreviate = T )
axis(side=1, labels = c("Thu","Fri","Sat"), tick =TRUE , at=c(0, length(gap)/2, length(gap)),
     cex.axis=0.8)

#-----------------------------------------------------------
# 4
grp=df$Global_reactive_power
plot(grp, ylab="Global_reactive_power", type="l", xlab = "datetime", xlim=c(0,2880), 
     xaxt="n", cex.axis=0.8)

lablist.x<-as.vector(c("Thu", "Fri", "Sat"))

weekdays(df[1,1],abbreviate = T )
weekdays(df[length(grp),10],abbreviate = T )

axis(side=1, labels = c("Thu","Fri","Sat"), tick =TRUE , at=c(0, length(grp)/2, length(grp)), 
     cex.axis=0.8)

par(mfrow=c(1,1))
dev.off(dev.cur())
#-----------------------------------------------------------
