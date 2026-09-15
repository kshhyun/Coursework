library(MASS)
library(ggplot2)
data(anorexia, package = "MASS")

# [데이터 구조 확인]
# 3개 치료 그룹(Treat)의 환자 수 동일한지 파악
ggplot(data = anorexia, aes(x = Treat)) + geom_bar() + 
  xlab("") + ylab("")

# [치료 전/후 몸무게 산점도]
ggplot(data = anorexia, aes(x = Prewt, y = Postwt, colour = Treat)) + 
  geom_point() + facet_grid(. ~ Treat) + 
  xlim(c(68, 115)) + ylim(c(68, 115))

# --------------------------------------------
# [치료 전/후 몸무게 산점도]
# 시각화 축의 일관성을 위해 전체 몸무게 최소~최대 범위 설정
limits <- with(anorexia, range(c(Prewt, Postwt)))
limits <- limits + 0.5 * c(-1, 1) * limits

# gplot 시각화
ggplot(data = anorexia, aes(x = Prewt, y = Postwt, colour = Treat)) + 
  coord_equal(ylim = limits, xlim = limits) +   # 가로세로 축 비을 1:1로 고정
  xlab("치료 전 몸무게 (lbs 단위)") +          
  ylab("치료 후 몸무게 (lbs 단위)") +         
  # y = x 대각 기준선 생성
  geom_abline(intercept = 0, slope = 1, colour = "white", linewidth = 1.25) + 
  geom_point(size = 3) +                        # 산점도 점 크기 3
  facet_grid(. ~ Treat) +                       # 치료 그룹(Treat)별 가로 격자 분할
  scale_colour_discrete(guide = "none") +       # 중복되는 우측 색상 범례 숨기기
  theme(text = element_text(family = "AppleGothic"))  # MacOS 폰트
# --------------------------------------------
# [치료 방식에 따른 치료전/후 체중 변화율(%)] 
ggplot(data = anorexia, aes(x = Prewt, colour = Treat, y = (Postwt - Prewt) / Prewt * 100)) +
  # y = 0 기준선 생성
  geom_hline(yintercept = 0, linewidth = 1.25, colour = "white") + 
  geom_point(size = 3) +                        # 산점도 점 크기 3
  facet_grid(. ~ Treat) +                       # 치료 그룹(Treat)별 가로 격자 분할
  xlab("치료 전 몸무게 (lbs 단위)") + 
  ylab("체중 변화율 %") +  
  scale_colour_discrete(guide = "none") +       # 범례 숨기기
  theme(text = element_text(family = "AppleGothic"))  # MacOS 폰트
