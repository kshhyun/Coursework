library(ggplot2)
setwd("~/Study/CourseWork/Coursework/BigData/CSV")
DF <- read.csv("coffee_monthly_sales.csv")
str(DF)

ggplot(data = DF, aes(x = Menu, y = No, fill = Menu)) +
  geom_boxplot() +
  stat_summary(fun = "mean", geom = "point", 
               shape = 21, size = 3, fill = "red") +
  theme(axis.title.x = element_blank()) +
  labs(title = "한양커피숍의 판매량",
       y = "수량")