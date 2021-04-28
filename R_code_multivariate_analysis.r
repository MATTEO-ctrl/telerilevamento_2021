# R_code_multivariate_analysis.r
library(raster) 
library(RStoolbox)
setwd("C:/lab/")
# l'immagine è composta da 7 bande
p224r63_2011 <-brick("p224r63_2011_masked.grd")
plot(p224r63_2011)
# vediamo le varie bande associate
plot(p224r63_2011$B1_sre,p224r63_2011$B2_sre, col="red", pch=19, cex=2)
# associando la banda1 e la banda2 notiamo che le bande sono ben correlate tra loro con un indice di 0.93
pairs(p224r63_2011)
# la funzione pairs ci permette di plottare tutte le correlazioni possibili e quindi anche di capire la miglior correlazione. Inoltre abbiamo indici che spaziano tra -1 e 1 che quantificano la correlazione
# la correlazione di Pearson tra le varie bande è sempre positiva e prossima al valore 1 indicando un'ottima correlazione tra le bande.

# funzione "aggregate cells" unisce i vari pixel di un fattore 10 lineare in modo da avere un immagine con dimensione minore e risoluzione più bassa.
p224r63_2011res <- aggregate(p224r63_2011, fact=10)
# il nostro pixel non sarà più di 30metri ma di 300metri
par(mfrow=c(2,1))
plotRGB(p224r63_2011, r=4, g=3, b=2, stretch="lin")
plotRGB(p224r63_2011res, r=4, g=3, b=2, stretch="lin")
# e ben visibile nella prima immagine il maggiore dettaglio che corrisponde ad una migliore risoluzione.

# funzione "rasterPCA" compatta il nostro pacchetto di dati in un numero minore di bande.
p224r63_2011res_pca <- rasterPCA(p224r63_2011res)
# funzione "summary" ci fornisce un sommario del nostro modello
summary(p224r63_2011res_pca$model)
# le prime 3 componenti PCA spiegano il 99% della variabilità quindi sono sufficienti per spiegare tutta la variabilità possibile
plot(p224r63_2011res_pca$map)
# si vede la prima componente con molte informazioni data dalla variabilità mentre l'ultima con pochissima informazione.
plotRGB(p224r63_2011res_pca$map, r=1, g=2, b=3, stretch="lin")
# vediamo un immagine con le 3 componenti principali 
