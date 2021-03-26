# My first code in R!!
# setwd("C:/lab/") # Windows 
# install.packages("raster")
library(raster)
p224r63_2011 <-brick("p224r63_2011_masked.grd")
p224r63_2011 
plot(p224r63_2011)
# a vector of colours
cl <- colorRampPalette(c("blue","orange","green")) (100)
#the first argument of the function is the image we want to plot!
plot(p224r63_2011,col=cl)
