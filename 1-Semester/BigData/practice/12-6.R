# Using the 'mtcars' data frame
library(ggplot2)
str(mtcars)
ggplot(data=mtcars) +
  geom_bar(mapping = aes(x=cyl, fill=as.factor(am)),
           position = "dodge") + 
  theme(legend.position = "bottom") +
  scale_fill_discrete(name = "변속기", 
                      labels=c("automatic", "manual")) +
  labs(x = "실린더 수(4, 6, 8)",
       y = "자동차 수",
       title = "실린더 수에 따른 자동차 분석")