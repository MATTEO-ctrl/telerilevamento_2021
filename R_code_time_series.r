# Analisi della serie dei tempi
# Incremento della temperatura in Groenlandia
# dati e codice da Emanuela Cosma
library(raster)
setwd("C:/lab/GREENLAND") 
lst_2000 <- raster("lst_2000.tif")
plot(lst_2000) 
lst_2005 <- raster("lst_2005.tif")
plot(lst_2005)
lst_2010 <- raster("lst_2010.tif")
plot(lst_2010)
lst_2015 <- raster("lst_2015.tif")
plot(lst_2015)
par(mfrow=c(2,2))
plot(lst_2000)
plot(lst_2005)
plot(lst_2010)
plot(lst_2015)
# Applico una funzione raster ad una lista di file 
# bisogna fare una lista di fila prima 
rlist <- list.files(pattern="lst")
rlist
import <- lapply(rlist,raster)
import
# la funzione "stack" crea un gruppo di file raster
TGr <- stack(import)
plot(TGr)
#sovrapposizione di tre immagini quindi ho associato i tre livelli ad RGB (la mappa essendo principalmente blu abbiamo valori più alti nel 2010)
plotRGB(TGr, 1, 2, 3, stretch="Lin")
