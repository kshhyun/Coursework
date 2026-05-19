setwd("~/Study/CourseWork/Coursework/BigData/CSV")
DF <- read.csv("adv_sales.csv")
str(DF)

time <- DF$ADV
sales <- DF$Sales
table <- data.frame(time, sales)

plot(table, main="광고 시간과 커피 판매량 추이", 
     xlab="시간(분)", ylab="판매량(잔)", 
     pch=8, col="blue")

res <- lm(sales~time, data=table)
abline(res, lwd=2, col="red")
cor(time, sales)