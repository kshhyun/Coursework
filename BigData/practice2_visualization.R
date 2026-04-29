# [0428] ====================================================
# 9-5 -------------------
No <- c(1:40)
Blood <- c("A", "B", "A", "O", "AB", "O", "O", "AB", "A","A",
           "AB", "A", "A", "O", "O", "O", "A", "AB", "O","O",
           "A", "B", "O", "O", "B", "A", "A", "AB", "A","A",
           "O", "B", "B", "O", "AB", "AB", "O", "AB", "O","O")

student <- data.frame(No, Blood)

setwd("~/Study/CourseWork/Coursework/BigData/practice")  #저장할 경로 설정
write.csv(student, "student_blood_types.csv", row.names = F)

# 도수분포표
student_freq <- table(student$Blood)
student_freq
#상대도수
student_Rfreq <- prop.table(student_freq)
student_Rfreq

barplot(student_Rfreq)

# 9-5-1 -------------------
setwd("~/Study/CourseWork/Coursework/BigData/practice")
student <- read.csv("student_blood_types.csv")
str(student)
student_freq <- table(student$Blood)

barplot(student_freq, main="학생들의 혈액형 분포", 
        col=rainbow(4), xlab="혈액형", ylab="명 수")

# 9-5-2 -------------------
setwd("~/Study/CourseWork/Coursework/BigData/practice")
student <- read.csv("student_blood_types.csv")
str(student)
student_freq <- table(student$Blood)

# 한글 깨짐 이슈
#par(family = "AppleGothic")

barplot(student_freq, main="학생들의 혈액형 분포", 
        col=rainbow(4), xlab="학생 수",
        ylab="혈액형", horiz=T)

# 9-5-3 -------------------
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