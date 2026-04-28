library(ggplot2)

DF <- data.frame(state.x77)

ggplot(data = DF, 
       aes(x = c(1:50), y = Frost, color = rownames(DF))) +
  geom_point(size=3) +
  theme(axis.title.x = element_blank(), 
        legend.title = element_blank()) +
  labs(title = "미국 50개 주의 서리 내린 회수 분포",
       y = "서리가 내린 날(일)")