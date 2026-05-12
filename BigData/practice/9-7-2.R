mag <- quakes$mag
par(mfrow=c(1,2)) # multiple figure: 2개 표시(1행 2열)

hist(mag, main="피지섬의 지진 발생 분포",
     xlab="지진 강도", ylab="발생건수",
     col=rainbow(10), breaks=seq(4.0, 6.7, by=0.2), freq=F)
lines(density(mag), lwd=5)

hist(mag, main="피지섬의 지진 발생 분포",
     xlab="지진 강도", ylab="발생건수",
     col=brewer.pal(10, "Pastel2"), breaks=seq(4.0, 6.7, by=0.1), freq=F)
lines(density(mag), col="red", lwd=2)