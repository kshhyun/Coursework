setwd("~/Study/CourseWork/Coursework/BigData/CSV")
student <- read.csv("student_blood_types.csv")
student_freq <- table(student$Blood)
student_freq
pie(student_freq)