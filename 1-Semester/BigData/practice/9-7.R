setwd("~/Study/CourseWork/Coursework/BigData/CSV")
student <- read.csv("student_body.csv")
str(student)
par(family = "AppleGothic")
hist(student$Height, main="피지섬의 지진 발생 분포", 
     col=rainbow(5), xlab="지진 강도", ylab="발생건수")
