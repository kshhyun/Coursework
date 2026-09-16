#표준정규분포와 t-분포
library(ggplot2)

ggplot(data.frame(x=c(-3,3)), aes(x=x)) +
  stat_function(fun=dnorm, colour="red", linewidth=1) +
  stat_function(fun=dt, args=list(df=9), colour="green", linewidth=1) +  
  stat_function(fun=dt, args=list(df=3), colour="blue", linewidth=1) +
  stat_function(fun=dt, args=list(df=1), colour="magenta", linewidth=1) +
  annotate("segment", x=1.5, xend=2, y=0.4, yend=0.4, colour="red", linewidth=1) +
  annotate("segment", x=1.5, xend=2, y=0.37, yend=0.37, colour="green", linewidth=1) + 
  annotate("segment", x=1.5, xend=2, y=0.34, yend=0.34, colour="blue", linewidth=1) +
  annotate("segment", x=1.5, xend=2, y=0.31, yend=0.31, colour="magenta", linewidth=1) +  
  annotate("text", x=2.4, y=0.4, label="N(0,1)") +
  annotate("text", x=2.4, y=0.37, label="t(9)") + 
  annotate("text", x=2.4, y=0.34, label="t(3)") + 
  annotate("text", x=2.4, y=0.31, label="t(1)") +   
  ggtitle("정규분포와 t-분포") +
  labs(y="p(x)")