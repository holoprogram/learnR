library(ggplot2)
# problem 1
## graphics

plot(pressure$pressure, pressure$temperature)

plot(pressure$pressure, pressure$temperature, main = "Pressure", 
     xlab = "压力", ylab = "水蒸气温度")


## ggplot2
ggplot(pressure, aes(pressure, temperature))+geom_point()
ggplot(pressure, aes(pressure, temperature))+labs(title = "Pressure")+
        xlab("压力")+ylab("水蒸气温度")+geom_point()

# problem 2
## graphics
pie(VADeaths[,"Rural Male"], radius = 1, main = "Death in Rural Male")
pie(VADeaths[1,],radius = 1, main = "Death in Age of 50-54")

## ggplot2
VADeaths <- as.data.frame(VADeaths)
bp1<- ggplot(VADeaths, aes(x="", y=`Rural Male`, 
                        fill=rownames(VADeaths)))+
        geom_bar(width = 1, stat = "identity")
pie1 <- bp1 + coord_polar("y", start=0)+labs(fill = "Ages")

pie1+theme(axis.text = element_blank()) + 
        theme(axis.ticks = element_blank()) 

VADeaths2 <- as.data.frame(t(VADeaths))
bp2 <- ggplot(VADeaths2, aes(x="", y=`50-54`, 
                        fill=rownames(VADeaths2)))+
        geom_bar(width = 1, stat = "identity")
pie2 <- bp2 + coord_polar("y", start=0)+labs(fill = "Diff Area")

pie2+theme(axis.text = element_blank()) + 
        theme(axis.ticks = element_blank()) 

# problem 3
data1 <- data.frame("效果"=c(rep("无效",42), 
                        rep("好转", 14), rep("治愈", 28)))
data2 <- c(42, 14, 28)
names(data2) <- c("无效", "好转", "治愈")
## graphics
barplot(data2, space = 0.5, col = c("red","green","blue"))
## ggplot2
ggplot(data1, aes(效果))+geom_bar(aes(fill=效果))
