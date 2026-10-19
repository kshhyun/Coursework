# 필요한 패키지 설치
#install.packages("vegan")
#install.packages("ggplot2")

# 패키지 불러오기
library(vegan)
library(ggplot2)

# 데이터 불러오기
data(iris)

# 분석에 사용할 수치형 변수만 선택
iris_x <- iris[, 1:4]

# 변수 표준화
iris_scaled <- scale(iris_x)

# 거리행렬 계산(유클리드 거리)
iris_dist <- dist(iris_scaled, method = "euclidean")

# non-metric MDS 수행
set.seed(123)
nmds_result <- metaMDS(
  iris_dist,
  k = 2,              # 2차원 해
  trymax = 100,       # 반복 시도 횟수
  autotransform = FALSE,
  trace = FALSE
)

# 결과 확인
nmds_result

# Stress 값 확인
nmds_result$stress

# NMDS 좌표 추출
nmds_points <- as.data.frame(scores(nmds_result, display = "sites"))

# 품종 정보 추가
nmds_points$Species <- iris$Species

# 좌표 확인
head(nmds_points)

# 시각화
ggplot(nmds_points, aes(x = NMDS1, y = NMDS2, color = Species)) +
  geom_point(size = 3, alpha = 0.8) +
  theme_minimal() +
  labs(
    title = "Non-metric MDS 결과",
    subtitle = paste("Stress =", round(nmds_result$stress, 4)),
    x = "NMDS1",
    y = "NMDS2",
    color = "Species"
  )