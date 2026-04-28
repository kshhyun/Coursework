UCBAdmissions

#Array 데이터를 평면분할표로 변환: Flat contingency table
ftable(UCBAdmissions)
library(vcd)

mosaicplot(~Dept + Gender + Admit, data=UCBAdmissions,
           xlab="", ylab="Gender",
           color=c("green", "red"),
           dir = c("v","h","v"))
