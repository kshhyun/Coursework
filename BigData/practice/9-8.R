str(quakes)
Q <- quantile(quakes$mag)
value.upper <- Q[4] + 1.5*IQR(quakes$mag)
value.lower <- Q[2] - 1.5*IQR(quakes$mag)
# IQR(quakes$mag)
boxplot(quakes$mag, main="피지섬의 지진 규모 분포", 
        ylab="지진 강도", col='skyblue')