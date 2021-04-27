# R_code_multivariate_analysis.r
library(raster) 
library(RStoolbox)
setwd("C:/lab/")
p224r63_2011 <-brick("p224r63_2011_masked.grd")
plot(p224r63_2011)
# vediamo le varie bande associate
plot(p224r63_2011$B1_sre,p224r63_2011$B2_sre, col="red", pch=19, cex=2)
# abbiamo due bande ben correlate tra loro con un indice di 0.93
pairs(p224r63_2011)
# la funzione pairs ci permette di plottare tutte le correlazioni possibili e quindi anche di capire la miglior correlazione. Inoltra abbiamo gli indici che spaziano tra -1 e 1 e quindi quantificano la correlazione
#
