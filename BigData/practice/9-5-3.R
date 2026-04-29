setwd("~/Study/CourseWork/Coursework/BigData/CSV")
Class_A <- read.csv("student_blood_types_A.csv")
Class_B <- read.csv("student_blood_types_B.csv")
A_freq <- table(Class_A$Blood)
B_freq <- table(Class_B$Blood)
student_freq <- rbind(A_freq, B_freq)
student_freq

remark <- c("A반", "B반")
barplot(student_freq, main="학생들의 혈액형 분포", 
        col=c("green", "blue"), xlab="혈액형",
        ylab="학생 수", legend.text=remark, 
        args.legend=list(x="top", ncol=2))