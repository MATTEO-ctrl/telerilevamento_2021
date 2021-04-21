# R_code_classificazione.r
# scaricato un immagine che rappresenta i diversi livelli energetici di una parte del sole
setwd("C:/lab/")
# usiamo la funzione brick che utilizza un pacchetto di dati e li unisce 
library(raster)
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

plotRGB(solar, 2,1,3, stretch="lin")
cplotRGB(solar, 3,2,1, stretch="lin")
