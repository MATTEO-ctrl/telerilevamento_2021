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
# 
