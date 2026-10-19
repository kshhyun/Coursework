setwd("D:/work")
usedcars <- read.csv("중고국산차현황.csv", fileEncoding = "EUC-KR")
str(usedcars)

# 연료 타입과 제조사만 추출
usedcars <- subset(usedcars, select=c(car_fuel, car_maker))
head(usedcars)

# 제조사에 대한 빈도 분석
freq_data <- table(usedcars$car_maker)
pfreq_data <- prop.table(freq_data)*100

# 백분율을 반올림하여 소숫점이하 1자리로 표현
pfreq_data <- round(pfreq_data, 1)

# 빈도와 백분율 바인딩
freq_table <- cbind(freq_data, pfreq_data)
freq_table

# 파이 차트
car_labels <- paste(rownames(freq_data), ",", pfreq_data, "%", sep=" ")
pie(freq_data, labels=car_labels, col=rainbow(7), main="제조사 비율(%)",
    init.angle=90, clockwise=T)

