#Project Idea: Exploring corelation between crime distribution and socioeconomic data for Chicago
library(sqldf)
library(RH2)
crimeDf <- read.csv("./Chicago-Crimes_2008-2012.csv",header=TRUE) 
socioDf <- read.csv("./Chicago-socio_data_2008-2012.csv",header=TRUE) 

summary(crimeDf$Community.Area)
summary(socioDf$Community.Area.Number)

#plot number of arrests vs diff indicators grouped by community.area.number
arrests <- subset(crimeDf,as.logical(Arrest)==TRUE,select=c(Primary.Type, Community.Area, Latitude, Longitude))

library(maps)
library(mapdata)
library(maptools)  #for shapefiles
library(scales)  #for transparency

arrests <- subset(crimeDf,as.logical(Arrest)==TRUE,select=c(Primary.Type, Community.Area, Latitude, Longitude))
library(rgdal)
areas <- readOGR(dsn = "./Boundaries/",layer = "CommAreas")
#spplot(areas, zcol=1, col.regions="gray", col="blue")
#plot(areas, col="gray", border="blue", axes=TRUE, pbg="white")

areas2 <- spTransform(areas, CRS("+proj=longlat +datum=WGS84")) #change projection

map("worldHires","usa", xlim=c(-87.95,-87.5),ylim=c(41.62,42.04), col="gray90", fill=TRUE)  #plot chicago using x-ylim
palette(gray.colors(10, 0.9, 0.4)
plot(areas2, add=TRUE, xlim=c(-87.95,-87.5),ylim=c(41.62,42.04), col=1:10, border="blue",axes=TRUE,pbg="white")  #plot the area
points(arrests$Longitude[arrests$Primary.Type=="ARSON"], arrests$Latitude[arrests$Primary.Type=="ARSON"], pch=19, col="red", cex=0.5)  #plot arrest coordinates 

par(mar=rep(0,4))

#arrests <- sqldf("select Primary.Type, Community.Area, Latitude, Longitude from crimeDf where Arrest==TRUE")
