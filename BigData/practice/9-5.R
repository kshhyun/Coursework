No <- c(1:40)
Blood <- c("A", "B", "A", "O", "AB", "O", "O", "AB", "A","A",
           "AB", "A", "A", "O", "O", "O", "A", "AB", "O","O",
           "A", "B", "O", "O", "B", "A", "A", "AB", "A","A",
           "O", "B", "B", "O", "AB", "AB", "O", "AB", "O","O")

student <- data.frame(No, Blood)

setwd("D:/source")
write.csv(student, "student_blood_types.csv", row.names = F)

student_freq <- table(student$Blood)
student_freq
student_Rfreq <- prop.table(student_freq)
student_Rfreq

barplot(student_Rfreq)