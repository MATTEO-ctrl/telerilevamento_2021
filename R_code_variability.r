# R_code_variability.r
library(raster)
library(RStoolbox)
setwd("C:/lab/")
sent <-brick("sentinel.png")
# NIR 1, RED 2, GREEN 3 non serve inserire nella funzione plotRGB(sent, r=1, g=2, b=3)dato che è già impostata di default.
plotRGB(sent)
# moving windows(finestra mobile)
NIR <-sent$sentinel.1
RED <-sent$sentinel.2
ndvi <-(NIR-RED)/(NIR+RED)
plot(ndvi)
# l'immagine ci dice che il colore bianco è assenza di vegetazione, il marrone è la roccia esposta il verde e il giallo sono le parti con vegetazione.
cl <- colorRampPalette(c('black', 'white', 'red', 'blue', 'magenta', 'green')) (100)
plot(ndvi, col=cl)
# possiamo ora calcolare la deviazione standard dell'immagine utilizzando la funzione 'focal'.
ndvisd3 <- focal(ndvi, w=matrix(1/9, nrow=3, ncol=3), fun=sd)
clsd <- colorRampPalette(c('blue', 'green', 'pink', 'magenta', 'orange', 'brown', 'red', 'yellow')) (100)
plot(ndvisd3, col=clsd)
# si nota un netto contrasto tra le praterie di alta quota e la roccia nuda
# calcoliamo la media 
ndvimean3 <- focal(ndvi, w=matrix(1/9, nrow=3, ncol=3), fun=mean)
plot(ndvimean3, col=clsd)
# valori molto alti nelle praterie di alta quota e la parte dei boschi di latifoglie e conifere e valori bassi nella roccia nuda.
# modifico la finestra in 9x9 quindi cambio il numero di pixel.
ndvisd3 <- focal(ndvi, w=matrix(1/81, nrow=9, ncol=9), fun=sd)
plot(ndvisd3, col=clsd)
# modifico in 5x5 che risulta a dimensione più ideale per il caso in esame
ndvisd3 <- focal(ndvi, w=matrix(1/25, nrow=5, ncol=5), fun=sd)
plot(ndvisd3, col=clsd)
# PCA
sentpca <- rasterPCA(sent)
plot(sentpca$map)
# passando tra le varie PC si perde l'informazione 
summary(sentpca$model)
# la prima PC spiega il 67.3% della variabilità originale.


library(ggplot2)
# install.packages("viridis")
library(viridis)
library(gridExtra)
