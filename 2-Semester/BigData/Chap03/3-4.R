library(MASS)

# 유럽 도시들간의 거리 데이터(matrix)
data(eurodist)
eurodist

# 유럽 도시들을 2차원으로 mapping
loc <- cmdscale(eurodist)

x <- loc[ , 1]
y <- -loc[ , 2] # 북쪽 도시를 상단에 표시하기 위해 부호 변경

# 시각화
# asp : y/x aspect ratio
plot(x, y, type = "n", asp = 1, main = "Metric MDS")
text(x, y, rownames(loc), cex = 0.8)
abline(v = 0, h = 0, lty = 2, lwd = 1)