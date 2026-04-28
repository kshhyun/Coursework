#Using the 'quakes' data frame
mag <- quakes$mag
hist(mag, main="피지섬의 지진 발생 분포",
     xlab="지진 강도", ylab="발생건수",
     col=rainbow(10), breaks=seq(4.0, 6.7, by=0.2))
