# R_code_classificazione.r
# scaricato un immagine che rappresenta i diversi livelli energetici di una parte del sole 
library(raster)
library(RStoolbox)
setwd("C:/lab/")
# usiamo la funzione brick che utilizza un pacchetto di dati e li unisce
solar <-brick("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")
# lavoriamo con bande già elaborate
#visualizziamo i livelli RGB 
plotRGB(solar, 1,2,3, stretch="lin")
# vediamo 3 livelli energetici partendo dalla destra il livello a più alta energia dove sono sono presenti le tempeste solari a seguire il livello intermedio e il più basso infine.
library(RStoolbox)
# classificazione con apprendimento non supervisionato.
soc <- unsuperClass(solar, nClasses=3)
# la funzione ha creato una parte sul modello e la mappa in uscita.
# quindi bisogna fare un plot della nostra immagine classificata soc in particolare della mappa
plot(soc$map)
# classificazione con apprendimento non supervisionato con 20 classi.
sol <- unsuperClass(solar, nClasses=20)
plot(sol$map)
# download immagine da: https://www.esa.int/ESA_Multimedia/Missions/Solar_Orbiter/(result_type)/images
SUN <-brick("The Sun.png")
# classificazione con apprendimento non supervisionato con 3 classi.
sunc <- unsuperClass(SUN , nClasses=3)
plot(sunc$map)
# abbiamo un immagine con i livelli ben definiti in questo caso
# Immagine GRAND CANYON composto da scisti nella parte basale e rocce vulcaniche nella parte superiore. La mineralogia che è all'interno di queste rocce determinerà la riflettanza.
# usando la riflettanza possiamo classificare la nostra immagine che è un RGB quindi formata da tre livelli.
gc <-brick("dolansprings_oli_2013088_canyon_lrg.jpg")
# plottiamo l'immagine con la seguente funzione sia con stretch linear sia stretch hist per vedere le differenze in particolare con hist si nota meglio la tridimensionalità
plotRGB(gc, r=1, g=2, b=3, stretch="lin")
plotRGB(gc, r=1, g=2, b=3, stretch="hist")
gcc2 <-unsuperClass(gc, nClasses=2)
plot(gcc2$map)
# si dissociano molto bene le due classi date da due litologie differenti
gcc4 <-unsuperClass(gc, nClasses=4)
plot(gcc4$map)
