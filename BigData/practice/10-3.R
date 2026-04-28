#Using the 'mtcars' data frame
str(mtcars)

vars <- c("mpg", "disp", "wt", "cyl")
target <- mtcars[ , vars]
head(target)
pairs(target, main="연비, 배기량, 무게, 실린더 수에 따른 산포도",
      col=rainbow(4))
