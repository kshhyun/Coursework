#Using the 'iris' data frame
library(ggplot2)

ggplot(data = iris,
  aes(x = Sepal.Length, y = Sepal.Width)) + 
  geom_point(col = c("red", "green", "blue")[iris$Species], 
             pch = c(1, 2, 3)[iris$Species],
             size = 2) +
  labs(title = "꽃받침의 길이와 폭에 대한 산포도", 
       x="꽃받침의 길이(Sepal.Length)", 
       y="꽃받침의 폭(Sepal.Width)")
