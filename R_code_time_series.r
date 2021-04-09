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
# la funzione "stack" crea un unico gruppo di file raster
TGr <- stack(import)
plot(TGr)
#sovrapposizione di tre immagini quindi ho associato i tre livelli ad RGB (la mappa essendo principalmente blu abbiamo valori più alti nel 2010)
plotRGB(TGr, 1, 2, 3, stretch="Lin")
# avremo due grafici che rappresentano la media dei valori sia per le righe che le colonne. I valori di lst sulla calotta glaciale sono più bassi nella parte centrale del grafico.
levelplot(TGr)
levelplot(TGr$lst_2000)
# cambiamo i colori dell'immagine e possiamo vedere multitemporalmente cosa è successo. Il colore blu scuro indica il valore di temperatura più basso
cl <- colorRampPalette(c("blue","light blue","pink","red"))(100)
levelplot(TGr, col.regions=cl)
# possiamo rinominare in modo diverso gli attributi e inserire un titolo al nostro plot
levelplot(TGr,col.regions=cl,main="Summer land surface temperature",names.attr=c("July 2000","July 2005", "July 2010", "July 2015"))
#stima relativa sul ghiaccio perso dal 1979 al 2007
meltlist <- list.files(pattern="melt")
melt_import <- lapply(meltlist,raster)
melt <- stack(melt_import)
levelplot(melt)
# abbiamo un raster stack con i nomi dei vari layer
# riusciamo a vedere lo scioglimento effettivo tra il 1979 e il 2007 
melt_amount <- melt$X2007annual_melt - melt$X1979annual_melt
plot(melt_amount, col=clb)
# le zone rosse sono quelle dove c'è stato uno scioglimento del ghiaccio più alto
levelplot(melt_amount, col.regoins=clb)
# abbiamo un pocco nella fascia sud-ovest della Groenlandia
