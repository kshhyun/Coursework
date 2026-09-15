library(ggplot2)

ggplot(data.frame(x=c(0,10)), aes(x=x)) +
  stat_function(fun=dchisq, args=list(df=1), colour="black", size=1.2) +
  stat_function(fun=dchisq, args=list(df=2), colour="red", size=1.2) +
  stat_function(fun=dchisq, args=list(df=3), colour="green", size=1.2) + 
  stat_function(fun=dchisq, args=list(df=4), colour="blue", size=1.2) + 
  stat_function(fun=dchisq, args=list(df=5), colour="magenta", size=1.2) +
  annotate("segment", x=7.0, xend=8.5, y=1.0, yend=1.0, colour="black", size=1.2) +
  annotate("segment", x=7.0, xend=8.5, y=0.9, yend=0.9, colour="red", size=1.2) + 
  annotate("segment", x=7.0, xend=8.5, y=0.8, yend=0.8, colour="green", size=1.2) +
  annotate("segment", x=7.0, xend=8.5, y=0.7, yend=0.7, colour="blue", size=1.2) +
  annotate("segment", x=7.0, xend=8.5, y=0.6, yend=0.6, colour="magenta", size=1.2) +  
  annotate("text", x=9.2, y=1.0, label="n=1") +
  annotate("text", x=9.2, y=0.9, label="n=2") + 
  annotate("text", x=9.2, y=0.8, label="n=3") + 
  annotate("text", x=9.2, y=0.7, label="n=4") +   
  annotate("text", x=9.2, y=0.6, label="n=5") +   
  ggtitle("Chi-square distribution") +
  labs(y="p(x)")