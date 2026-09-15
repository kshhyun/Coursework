setwd("~/Study/CourseWork/Coursework/BigData/practice")
student <- read.csv("student_blood_types.csv")
str(student)
student_freq <- table(student$Blood)

barplot(student_freq, main="학생들의 혈액형 분포", 
        col=rainbow(4), xlab="혈액형", ylab="명 수")