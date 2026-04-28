library(ggplot2)

ggplot(data.frame(x=c(0,5)), aes(x=x)) +
  stat_function(fun=df, args=list(df1=1, df2=1), colour="black", size=1) +
  stat_function(fun=df, args=list(df1=2, df2=2), colour="red", size=1) +
  stat_function(fun=df, args=list(df1=5, df2=3), colour="green", size=1) +
  stat_function(fun=df, args=list(df1=10, df2=4), colour="blue", size=1) +
  stat_function(fun=df, args=list(df1=100, df2=100), colour="magenta", size=1) +  
  annotate("segment", x=3, xend=3.5, y=1.5, yend=1.5, colour="black", size=1) +
  annotate("segment", x=3, xend=3.5, y=1.3, yend=1.3, colour="red", size=1) + 
  annotate("segment", x=3, xend=3.5, y=1.1, yend=1.1, colour="green", size=1) + 
  annotate("segment", x=3, xend=3.5, y=0.9, yend=0.9, colour="blue", size=1) + 
  annotate("segment", x=3, xend=3.5, y=0.7, yend=0.7, colour="magenta", size=1) +   
  annotate("text", x=4.3, y=1.5, label="(n1=1,   n2=1)") +
  annotate("text", x=4.3, y=1.3, label="(n1=2,   n2=2)") + 
  annotate("text", x=4.3, y=1.1, label="(n1=5,   n2=3)") +
  annotate("text", x=4.3, y=0.9, label="(n1=10,  n2=4)") + 
  annotate("text", x=4.3, y=0.7, label="(n1=100, n2=100)") +  
  ggtitle("F-distribution") +
  labs(y="p(x)")