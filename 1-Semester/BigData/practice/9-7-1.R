#Using the 'quakes' data frame
str(quakes)
mag <- quakes$mag
par(mfrow=c(1,2)) # multiple figure: 2개 표시(1행 2열)
# row(행우선) / col(열우선)
hist(mag, main="피지섬의 지진 발생 분포",
     xlab="지진 강도", ylab="발생건수",
     col=brewer.pal(10, "Pastel2"), breaks=seq(4.0, 6.7, by=0.5))

#잘개 쪼개려고 by=0.5 -> by=0.1로 수정
hist(mag, main="피지섬의 지진 발생 분포",
     xlab="지진 강도", ylab="발생건수",
     #잘개 쪼개려고 by=0.2 -> by=0.1로 수정
     col=rainbow(10), breaks=seq(4.0, 6.7, by=0.1))