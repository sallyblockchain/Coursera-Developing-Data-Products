runApp(display.mode='showcase')

require(rCharts)
haireye <- as.data.frame(HairEyeColor)
n1 <- nPlot(Freq ~ Hair, group='Eye', type='multiBarChart', 
            data=subset(haireye, Sex=='Male')
)
n1$save('fig/n1.html', cdn=T)
cat('<iframe src="fig/n1.html" width=100%, height=600></iframe>')