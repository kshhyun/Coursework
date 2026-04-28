library(treemap)
DF <- data.frame(state.x77)

#include USA state names
New_DF <- data.frame(DF, state.name)

treemap(New_DF,
        index="state.name",
        vSize="Area",
        vColor="Income",
        type="value",
        title="미국 50개 주의 면적과 수입")
