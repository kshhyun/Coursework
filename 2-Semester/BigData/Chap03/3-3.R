setwd("D:/work")
data <- read.csv("cleanDescriptive.csv", fileEncoding = 'EUC-KR', header=TRUE)
head(data)

# 변수 추출
x <- data$level2  # 학력 수준
y <- data$pass2   # 진학 여부

# 데이터프레임 생성 
df <- data.frame(Level=x, Pass=y) 

# 교차분할표를 통해서 범주형 변수의 관계 분석
# table() 함수를 이용하여 빈도 분석  
table(df)

# CrossTable() 함수를 이용한 교차분할표 생성 및 카이스퀘어 검정
# 귀무가설(H0) : 부모의 학력수준과 자녀의 대학진학여부는 관련이 없다.
# 대립가설(H1) : 부모의 학력수준과 자녀의 대학진학여부는 관련이 있다.
# 유의 수준(알파) = 0.05
library(gmodels) # gmodels 패키지를 설치해야 함
CrossTable(x=df$Level, y=df$Pass, chisq = TRUE)

# 검정 결과 : p값이 유의 수준 알파보다 크므로 귀무가설 채택
# 따라서 대학의 진학여부는 부모의 학력 수준과는 관련성이 없다.
