library(Rtsne)
library(ggplot2)

#exclude iris$Species
DF <- iris[ , -5]

#remove duplication data
dup <- which(duplicated(DF))
DF <- DF[-dup, ]

#Species
DF_Species <- iris$Species[-dup]

#t-SNE
tsne <- Rtsne(DF, dims = 2, perplexity = 10)

#visualization
DF_tsne <- data.frame(tsne$Y)
ggplot(DF_tsne, aes(x=X1, y=X2, color=DF_Species)) +
  geom_point(size=3)