library(RColorBrewer)
greens <- brewer.pal(7, 'Greens')
city <- c("서울", "부산", "대구", "인천", "광주", "대전", "울산")
pm25 <- c(18, 21, 21, 17, 8, 11, 25)
pct <- round(pm25/sum(pm25)*100, 1)
city_labels <- paste(city, ",", pct, "%", sep="")
pie(pm25, labels=city_labels, col=greens, main="지역별 초미세먼지 농도(%)",
    init.angle=90, clockwise=T)