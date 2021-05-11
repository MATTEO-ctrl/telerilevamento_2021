# R_code_land_cover.r
library(raster)
library(RStoolbox)
# install.packages("ggplot2")
library(ggplot2)
setwd("C:/lab/")
defor1 <-brick("defor1.jpg")
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
ggRGB(defor1, r=1, g=2, b=3, stretch="lin")
defor2 <-brick("defor2.jpg")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
ggRGB(defor2, r=1, g=2, b=3, stretch="lin")
par(mfrow=c(1,2))
plotRGB(defor1, r=1, g=2, b=3, stretch="lin")
plotRGB(defor2, r=1, g=2, b=3, stretch="lin")
# multiframe with ggplot2 and gridExtra
# install.packages("gridExtra")
library(gridExtra)
p1 <-ggRGB(defor1, r=1, g=2, b=3, stretch="lin")
p2 <-ggRGB(defor2, r=1, g=2, b=3, stretch="lin")
grid.arrange(p1,p2, nrow=2)

#unsupervised classification
library(raster)
library(RStoolbox)
library(ggplot2)
library(gridExtra)
setwd("C:/lab/")
defor1 <-brick("defor1.jpg")
defor2 <-brick("defor2.jpg")
d1c <- unsuperClass(defor1, nClasses=2)
d1c
# abbiamo un raster layer con due valori
plot(d1c$map)
# la classe uno, rappresenta la zona agricola e il fiume(che ha simile riflettanza) mentre la classe due, la foresta amazzonica. Le due classi potrebbero essere invertite! Per ovviare a questo si usa la funzione set.seed()
d2c <- unsuperClass(defor2, nClasses=2)
plot(d2c$map)
# classificazione con 3 classi per individuare il fiume
d2c3 <- unsuperClass(defor2, nClasses=3)
plot(d2c3$map)
# il colore giallo rappresenta la parte residua di foresta amazzonica
# usiamo la funzione per calcolare la frequenza
freq(d1c$map)
#    1  34976
#    2 306316
s1 <- 34976 + 306316
s1
# 341292
prop1 <- freq(d1c$map)/s1
# abbiamo la classe della foresta con una proporzione più alta (89%) contro i campi agricoli (11%)
s2 <- 342726
prop2 <- freq(d2c$map)/s2
prop2
abbiamo la classe della foresta con una proporzione più alta (52%) contro i campi agricoli (48%)
# genero un dataset dove inserisco nella prima colonna i fattori(variabili categoriche) la foresta e i campi agricoli e nella seconda e terza colonna le percentuali iniziali di pixel e i valori degli anni corrispondenti.
cover <- c("Forest", "Agriculture")
percent_1992 <- c(89, 11)
percent_2006 <- c(52, 48)
# usiamo la funzione per creare un dataframe.
percentages <-data.frame(cover, percent_1992, percent_2006)
percentages
# usiamo ggplot2 per creare un grafico da indagine statistica 
P1 <- ggplot(percentages, aes(x=cover, y=percent_1992, color=cover)) + geom_bar(stat="identity", fill="light green")
P2 <- ggplot(percentages, aes(x=cover, y=percent_2006, color=cover)) + geom_bar(stat="identity", fill="light blue")
# il suolo agricolo è aumentato a discapito della foresta 
# usiamo la funzione grid.arrange per unire i due plot in un solo grafico in modo da confrontarli meglio.
grid.arrange(P1, P2, nrow=1)



