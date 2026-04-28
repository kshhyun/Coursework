library(ggplot2)

ggplot(data=iris, aes(x=Petal.Length, y=Petal.Width, color=Species)) +
  geom_point(size=3) +
  ggtitle("²ÉÀÙÀÇ ±æÀÌ¿Í Æø") + 
  theme(plot.title = element_text(size=16, face="bold", colour="steelblue"))