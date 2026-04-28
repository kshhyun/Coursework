setwd("D:/source")
Hanyang_Coffee <- read.csv("coffee_info.csv")
str(Hanyang_Coffee)
Hanyang_Coffee
View(Hanyang_Coffee)
summary(Hanyang_Coffee)
Hanyang_Coffee[Hanyang_Coffee$Beans == "Arabica", ]
