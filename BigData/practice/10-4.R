#Using the 'iris' data frame
str(iris)

#Select 'Petal.Length' and 'Petal.Width'
vars <- iris[ , 3:4]
point <- as.numeric(iris$Species)
plot_color <- c("red", "green", "blue")
remark <- c("setosa", "versicolor", "virginica")
plot(vars, main="Ç°Á¾¿¡ µû¸¥ ²ÉÀÙÀÇ ±æÀÌ¿Í ÆøÀÇ »êÆ÷µµ",
     xlab="²ÉÀÙÀÇ ±æÀÌ(Petal.Length)",
     ylab="²ÉÀÙÀÇ Æø(Petal.Width)",
     pch=c(point), col=plot_color[point])
