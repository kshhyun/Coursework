#using the 'student_body.csv' file 
setwd("D:/source")
DF <- read.csv("student_body.csv")
str(DF)

male <- subset(DF, Gender == "MALE")
female <- subset(DF, Gender == "FEMALE")
male
female

#하나의 화면에 여러개 시각화
par(mfrow=c(1, 2))
male_height <- male$Height
male_weight <- male$Weight
plot(male_height, male_weight, main="남성의 키와 몸무게 분포", 
     xlab="키", ylab="몸무게", pch=21,
     col="blue", bg="red", cex=1.5)

female_height <- female$Height
female_weight <- female$Weight
plot(female_height, female_weight, main="여성의 키와 몸무게 분포", 
     xlab="키", ylab="몸무게", pch=21,
     col="blue", bg="green", cex=1.5)