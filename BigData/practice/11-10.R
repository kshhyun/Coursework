library(treemap)
data(GNI2014)
str(GNI2014)
treemap(GNI2014,
        index="continent",
        vSize="population",
        type="index",
        title="대륙별 인구 분포")