# My first code in R!!
# Day 1
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
# Day 2
# colour change -> new
cl <- colorRampPalette(c("blue","green","grey","red","magenta","yellow")) (100)
plot(p224r63_2011, col=cl)
cl <- colorRampPalette(c("red","pink","orange","purple")) (200)
plot(p224r63_2011, col=cls)
# Day 3
# Bande Landsat
# B1: blu
# B2: green
# B3: red
# B4: near infrared
# B5: middle infrared
# B6: thermal infrared
# B7: middle infrared
# dev.off will clean the current graph
# dev.off()
plot(p224r63_2011$B1_sre)
# $ serves to bond
cls <- colorRampPalette(c("red","pink","orange","purple")) (200)
plot(p224r63_2011$B1_sre, col=cls)
# dev.off()
plot(p224r63_2011$B1_sre)
# 1 row, 2 columns
par(mfrow=c(1,2))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
# 2 row, 1 columns
par(mfrow=c(2,1)) # if you are using columns first: par(mfcol....)
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
# plot the first four bands of Landsat
par(mfrow=c(4,1))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
plot(p224r63_2011$B3_sre)
plot(p224r63_2011$B4_sre)
# a quadrat of bands...:
par(mfrow=c(2,2))
plot(p224r63_2011$B1_sre)
plot(p224r63_2011$B2_sre)
plot(p224r63_2011$B3_sre)
plot(p224r63_2011$B4_sre)
# a quadrat of bands...:
par(mfrow=c(2,2))
clb <- colorRampPalette(c("dark blue","blue","light blue")) (100)
plot(p224r63_2011$B1_sre, col=clb)
clg <- colorRampPalette(c("dark green","green","light green")) (100)
plot(p224r63_2011$B2_sre, col=clg)
clr <- colorRampPalette(c("dark red","red","pink")) (100)
plot(p224r63_2011$B3_sre, col=clr)
clnir <- colorRampPalette(c("red","orange","yellow")) (100)
plot(p224r63_2011$B4_sre, col=clnir)


