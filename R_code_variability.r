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

# utilizziamo la prima componente associando tutto ad un oggetto per poi utilizzare la funzione 'focal' e vedere come cambiano i valori su una singola banda.
pc1 <- sentpca$map$PC1
pc1sd5 <- focal(pc1, w=matrix(1/25, nrow=5, ncol=5), fun=sd)
clpc <- colorRampPalette(c('blue', 'green', 'pink', 'magenta', 'orange', 'brown', 'red', 'yellow')) (100)
plot(pc1sd5, col=clpc)
# si nota una grande variabilità geomorfologica. Le praterie di alta quota sono le zone più omogenee.
# La funzione 'source' permette di utilizzare un parte di codice che è fuori R e caricarlo direttamente dentro R.
source("source.test.lezione.r")
# codice all'esterno
pc1 <- sentpca$map$PC1
pc1sd7 <- focal(pc1, w=matrix(1/49, nrow=7, ncol=7), fun=sd)
plot(pc1sd7)
library(ggplot2)
library(gridExtra)
# install.packages("viridis") serve per colorare i plot in modo automatico. 
library(viridis)
source("source_ggplot.r")
ggplot() +
geom_raster(pc1sd5, mapping= aes( x=x, y=y, fill = layer))
# Possiamo individuare le varie discontinuità geogorafiche, le caratteristiche geomorfologiche della zona, e i vari ecotoni.
p1 <- ggplot() +
geom_raster(pc1sd5, mapping= aes( x=x, y=y, fill = layer)) +
scale_fill_viridis() +
ggtitle("Standard deviation of PC1 by Viridis colour scale")
# funzione "magma" le zone con alta deviazione standard si vedono molto chiaramente.
p2 <- ggplot() +
geom_raster(pc1sd5, mapping= aes( x=x, y=y, fill = layer)) +
scale_fill_viridis(option= "magma") +
ggtitle("Standard deviation of PC1 by magma colour scale")
# funzione "inferno"
p3 <- ggplot() +
geom_raster(pc1sd5, mapping= aes( x=x, y=y, fill = layer)) +
scale_fill_viridis(option= "turbo") +
ggtitle("Standard deviation of PC1 by turbo colour scale")
grid.arrange(p1, p2, p3, nrow=1)
# "Virdis" e "magma" sono più efficaci rispetto a "turbo" che pone il colore giallo come valori intermedi. Il colore giallo trasmette alla mostra mente che sia il valore massimo.


