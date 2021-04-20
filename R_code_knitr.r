# R_code_knitr.r 
# Combina molte caratteristiche in un unico pacchetto
setwd("C:/lab/") 
library(knitr)
stitch("R_code_greenland.txt", template=system.file("misc", "knitr-template.Rnw", package="knitr"))
