runApp(display.mode='showcase')

require(rCharts)
haireye <- as.data.frame(HairEyeColor)
n1 <- nPlot(Freq ~ Hair, group='Eye', type='multiBarChart', 
            data=subset(haireye, Sex=='Male')
)
n1$save('fig/n1.html', cdn=T)
cat('<iframe src="fig/n1.html" width=100%, height=600></iframe>')

# Facetted Scatterplot
names(iris) <- gsub("\\.", "", names(iris))
r1 <- rPlot(SepalLength ~ SepalWidth | Species, data=iris, 
            color='Species', type='point')
r1$save('fig/r1.html', cdn=T)
cat('<iframe src="fig/r1.html", width=100%, height=500></iframe>')

# Facetted Barplot
hair_eye <- as.data.frame(HairEyeColor)
r2 <- rPlot(Freq ~ Hair | Eye, color='Eye', data=hair_eye, type='bar')
r2$save('fig/r2.html', cdn=T)
cat('<iframe src="fig/r2.html" width=100%, height=600></iframe>')

r1 <- rPlot(mpg ~ wt | am + vs, data=mtcars, type="point", color="geat")
r1$print("chart1")
r1$save("myPlot.html")
r1$publish("myPlot", host='gist')
r1$publish("myPlot, host='rpubs")

# morris
data(economics, package="ggplot2")
econ <- transform(economics, date=as.character(date))
m1 <- mPlot(x="date", y=c("psavert", "uempmed"), type="Line", data=econ)
m1$set(pointSize=0, lineWidth=1)
m1$save('fig/m1.html', cdn=T)
cat('<iframe src="fig/m1.html" width=100%, height=600></iframe>')

# xCharts
require(reshape2)
uspexp <- melt(USPersonalExpenditure)
names(uspexp)[1:2]=c("category", "year")
x1 <- xPlot(value ~ year, group="category", data=uspexp, type="line-dotted")
x1$save('fig/x1.html', cdn=TRUE)
cat('<iframe src="fig/x1.html" width=100%, height=600></iframe>')

# Leaflet
map3 <- Leaflet$new()
map3$setView(c(51.505, -0.09), zoom=13)
map3$marker(c(51.5, -0.09), bindPopup="<p> Hi. I am a popup </p>")
map3$marker(c(51.495, -0.083), bindPopup="<p> Hi. I am another popup </p>")
map3$save('fig/map3.html', cdn=TRUE)
cat('<iframe src="fig/map3.html" width=100%, height=600></iframe>')

# Rickshaw
usp <- reshape2::melt(USPersonalExpenditure)
# get the decades into a date Rickshaw likes
usp$Var2 <- as.numeric(as.POSIXct(paste0(usp$Var2, "-01-01")))
p4 <- Rickshaw$new()
p4$layer(value ~ Var2, group="Var1", data=usp, type="area", width=560)
# add a helpful slider this easily; other features TRUE as a default
p4$set(slider=TRUE)
p4$save('fig/p4.html', cdn=TRUE)
cat('<iframe src="fig/p4.html" width=100%, height=600></iframe>')

# highchart
h1 <- hPlot(x="Wr.Hnd", y="NW.Hnd", data=MASS::survey, 
            type=c("line", "bubble", "scatter"), 
            group="Clap", size="Age")
h1$save('fig/h1.html', cdn=TRUE)
cat('<iframe src="fig/h1.html" width=100%, height=600></iframe>')

## GoogleVis
suppressPackageStartupMessages(library(googleVis))
M <- gvisMotionChart(Fruits, "Fruit", "Year", 
                     options=list(width=600, height=400))
print(M, "chart")

# "gvis + ChartType"
# Motion charts: gvisMotionChart
# Interactive maps: gvisGeoChart
# Interactive tables: gvisTable
# Line charts: gvisLineChart
# Bar charts: gvisColumnChart
# Tree maps: gvisTreeMap

G <- gvisGeoChart(Exports, locationvar="Country", colorvar="Profit", 
                  options=list(width=60, height=400))
print(G, "chart")

G2 <- gvisGeoChart(Exports, locationvar="Country", colorvar="Profit",
                   options=list(width=600, height=400, region="150"))
print(G2, "chart")

demo(googleVis)

# https://plot.ly/ggplot2/
library(plotly)
library(ggplot2)

data(iris)
set_credentials_file("Xiaodan", "lv1rsgko30")
ggiris <- qplot(Petal.Width, Sepal.Length, data = iris, color = Species)
ggiris
py <- plotly()
r <- py$ggplotly(ggiris)
r$response$url
