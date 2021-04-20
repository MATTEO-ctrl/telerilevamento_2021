# R_code_copernicus.r
# Copernicus global land service che fornire prodotti bio-geofisici della superficie terrestre globale.
library(raster)
# install.packages("ncdf4")
library(ncdf4)
setwd("C:/lab/")
# nome del mio dataset
Lake water quality <- raster("c_gls_LWQ300_202104010000_GLOBE_OLCI_V1.4.0.nc")
# digitando su R Lake water quality vediamo le caratteristiche quali classe, dimensione, sistema di riferimento.
