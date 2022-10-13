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


# problem 4
## graphics
# 4.1
hist(mtcars$mpg)
# 4.2
hist(mtcars$mpg,breaks = 12, col = "blue", border = "red")
# 4.3
dotchart(mtcars$mpg,labels = row.names(mtcars))

# 4.4
x<-mtcars[order(mtcars$mpg),]
x$cyl<-factor(x$cyl)
x$color[x$cyl==4]<-"red"
x$color[x$cyl==6]<-"blue"
x$color[x$cyl==8]<-"darkgreen"
dotchart(x$mpg,labels=row.names(x),groups=x$cyl,gcolor="black",color=x$color)


## ggplot2
ggplot(mtcars, aes(mpg))+geom_histogram(bins = 12)

ggplot(mtcars, aes(mpg))+
        geom_histogram(bins = 12, color ="red",fill="#4169E1")
ggplot(mtcars, aes(x=mpg,y = row.names(mtcars)))+
        geom_point()+theme(axis.title.y = element_blank())
ggplot(mtcars, aes(x=mpg,y = row.names(mtcars), color = as.factor(cyl)))+
        geom_point()+theme(axis.title.y = element_blank())


# problem 5
## graphics
coplot(Sepal.Length~Sepal.Width | Petal.Length * Petal.Width,data = iris)

## ggplot2
ggplot(iris, aes(Sepal.Length, Sepal.Width))+geom_point() +
        facet_grid(. ~ Species)

ggplot(iris, aes(Petal.Length, Petal.Width))+geom_point() +
        facet_grid(. ~ Species)

