library(MASS)
library(vegan)
library(ggplot2)

# 제품 간 비유사도 행렬 생성
dissimilarity_matrix <- matrix(c(
  0, 2, 3, 7, 8, 9,
  2, 0, 4, 6, 7, 8,
  3, 4, 0, 5, 6, 7,
  7, 6, 5, 0, 2, 3,
  8, 7, 6, 2, 0, 2,
  9, 8, 7, 3, 2, 0
), nrow = 6, byrow = TRUE)

# 행과 열 이름 지정
rownames(dissimilarity_matrix) <- colnames(dissimilarity_matrix) <- 
  c("Product_A", "Product_B", "Product_C", 
    "Product_D", "Product_E", "Product_F")

# 거리 객체로 변환
product_dist <- as.dist(dissimilarity_matrix)

# non-metric MDS 수행
set.seed(123)  #실행할때마다 동일한 결과가 나오도록 함
product_nmds <- metaMDS(
  product_dist,
  k = 2,
  trymax = 100,
  autotransform = FALSE,
  trace = FALSE
)

# 결과 확인
product_nmds
product_nmds$stress

# 좌표 추출
product_points <- as.data.frame(scores(product_nmds, display = "sites"))

# 제품명 추가
product_points$Product <- rownames(product_points)

# 시각화
ggplot(product_points, aes(x = NMDS1, y = NMDS2, label = Product)) +
  geom_point(size = 4, color = "steelblue") +
  geom_text(vjust = -0.8, size = 4) +
  theme_minimal() +
  labs(
    title = "제품 간 유사성에 대한 non-metric MDS",
    subtitle = paste("Stress =", round(product_nmds$stress, 4)),
    x = "NMDS1",
    y = "NMDS2"
  )