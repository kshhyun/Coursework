str(Titanic)
ftable(Titanic)

mosaicplot(~Class + Survived, 
           data = Titanic,
           xlab="선실등급(Class)", 
           ylab="생존여부(Survived)",
           color=c("pink", "lightblue"),
           cex = 1,
           dir = c("v","h"))