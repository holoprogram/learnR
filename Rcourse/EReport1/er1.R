# experimental report 1

## question 1.1
a <- seq(1, 20, by = 3)
mean(a)
median(a)
var(a)

## question 1.2
b <- c(1, 3)
a2 <- a[-b]

## question 2
vec1 <- c(rep(1,5), rep(2,3), rep(3,4), rep(4,2))

## question 3
A <- matrix(1:20, nrow = 4)
B <- matrix(1:20, nrow = 4, byrow = TRUE)
C <- A[1:3, 1:3]
D <- B[,-3]



## question 4
read1 <- data.frame("姓名" = c("张三", "李四", "王五", "赵六", "丁一"),
                    "性别" = factor(c("女", "男", "女", "男", "女" )),
                    "年龄" = c(14, 15, 16, 14, 15),
                    "身高" = c(156, 165, 157, 162, 159),
                    "体重" = c(42.0, 49.0, 41.5, 52.0, 45.5))

## question 5
data <- read.table("er1data.txt", header = TRUE,
                   colClasses = c("character","factor","numeric","numeric","numeric"))
write.csv(data, "er1data.csv")