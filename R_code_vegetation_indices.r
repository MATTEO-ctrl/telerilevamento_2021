# R_code_vegetation_indices.r
library(raster) 
library(RStoolbox)
setwd("C:/lab/")
defor1 <-brick("defor1.jpg")
defor2 <-brick("defor2.jpg")
# b1=NIR, b2=red, b3=green
par(mfrow=c(2,1))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
# interessante notare come nella prima immagine il contenuto di solidi disciolti sia molto più alto rispetto all'immagine sottostante. L'acqua assorbe l'infrarosso quindi la purezza corrisponde al nero come colore.
# require(raster) stessa funzione di library(raster)
# Gli indici di vegetazione sono calcolati a partire da dati rilevati da satellite o drone.
# I satelliti di uso più comune hanno intervalli di acquisizione regolari, ad esempio di 5 giorni (Sentinel 2) o 16 giorni (Landsat 8).
# gli indici sono pertanto disponibili per più date nella stessa stagione.
# La vegetazione assorbe la radiazione solare in diverse bande, ossia in diversi intervalli di frequenza e lunghezze d’onda, e ne riemette una percentuale differente in ciascuna di esse.
# La percentuale di radiazione riemessa in bande specifiche, come quelle del vicino infrarosso (NIR), del rosso (RED), e dell’infrarosso a onde corte (Short Wave Infrared), indica lo stato di salute della pianta o lo stress idrico.
# tempo 1
dvi1 <- defor1$defor1.1 - defor1$defor1.2
plot(dvi1)
cl <- colorRampPalette(c('darkblue', 'yellow', 'red', 'black'))(100)
plot(dvi1, col=cl, main="DVI at time 1")
#tempo 2
dvi2 <- defor2$defor2.1 - defor2$defor2.2
plot(dvi2, col=cl, main="DVI at time 2")
# si vede molto bene come sia aumentata la deforestazione data dal colore giallo.
par(mfrow=c(2,1))
plot(dvi1, col=cl, main="DVI at time 1")
plot(dvi2, col=cl, main="DVI at time 2")
difdvi <- dvi1-dvi2
cld <- colorRampPalette(c('blue', 'white', 'red'))(100)
plot(difdvi, col=cld)
# le due immagini non hanno la stessa dimensione quindi calcolerà l'intersezione.
# Le zone del campo visibili in rosso sono quelle in cui c'è deforestazione.
# l’NDVI (Normalized Difference Vegetation Index): esso descrive il livello di energia della coltura e si calcola come il rapporto tra la differenza e la somma delle radiazioni riflesse nel vicino infrarosso e nel rosso, ossia come (NIR-RED)/(NIR+RED).
# Per identificare le aree potenzialmente problematiche di ciascun campo, si identifica il valore minimo e il valore massimo di NDVI nel campo.
# Dopodichè in mappa si ricolora il campo associando il colore rosso al valore minimo, e il colore verde al valore massimo(normalizzazione").
ndvi1 <- (defor1$defor1.1 - defor1$defor1.2) / (defor1$defor1.1 + defor1$defor1.2)
plot(ndvi1, col=cl)
# I valori possono variare tra -1 e 1, ma quelli compresi tra -1 e 0 sono tipici di aree non coltivate come corsi d’acqua e zone antropiche.
ndvi2 <- (defor2$defor2.1 - defor2$defor2.2) / (defor2$defor2.1 + defor2$defor2.2)
plot(ndvi2, col=cl)
# RStoolbox: spectralIndices
# per calcolare una grande varietà di indici 
library(RStoolbox)
vi <-spectralIndices(defor1, green=3, red=2, nir=1)
plot(vi, col=cl)
vi2 <-spectralIndices(defor2, green=3, red=2, nir=1)
plot(vi2, col=cl)
difndvi <- ndvi1 - ndvi2
cld <- colorRampPalette(c('blue','white','red'))(100) 
plot(difndvi, col=cld)
