library(Rtsne)
library(car)
library(rgl)
library(mgcv)

#exclude iris$Species
DF <- iris[ , -5]

#remove duplication data
dup <- which(duplicated(DF))
DF <- DF[-dup, ]

#Species
DF_Species <- iris$Species[-dup]

#t-SNE
tsne <- Rtsne(DF, dims = 3, perplexity = 10)

#visualization
DF_tsne <- data.frame(tsne$Y)
points <- as.integer(DF_Species)
color <- c("red", "green", "blue")
scatter3d(x=DF_tsne$X1, y=DF_tsne$X2, z=DF_tsne$X3,
          point.col = color[points],
          surface = T)