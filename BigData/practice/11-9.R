library(treemap)
data(GNI2014)
str(GNI2014)
treemap(GNI2014,
        index=c("continent","iso3"),
        vSize="population",
        vColor="GNI",
        type="value",
        bg.labels="red",
        title="Àü ¼¼°è ±¹¹ÎÃÑ¼Òµæ")