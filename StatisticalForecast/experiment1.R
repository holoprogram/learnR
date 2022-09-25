library(ggplot2)
library(readxl)



sy1 <- read_xls("sy1-1.xls", sheet = 1)

cor(sy1$固定资产投资完成额x, sy1$国内生产总值y)

ggplot(sy1, aes(固定资产投资完成额x, 国内生产总值y))+geom_point() +
        geom_smooth(method = "lm", se = FALSE)+ 
        theme_classic()+
        labs(title = "投资完成额与生产总值关系图")+
        theme(plot.title = element_text(face = "bold", family = "serif"))


# 回归分析
sy1 <- sy1[, 2:3]
names(sy1) <- c("X", "Y")
lm.sol <- lm(formula = Y~1+X, data = sy1)
summary(lm.sol)

# 预测
vec <- append(sy1$X, 5922)
new <- data.frame(X=vec)
pp <- predict(lm.sol, new, interval = "prediction")
pc <- predict(lm.sol, new, interval = "confidence")
par(mai = c(0.8,0.8,0.2,0.2))

matplot(new$X, cbind(pp,pc[,-1]), type = "l",xlab = "X", ylab = "Y", 
        lty = c(1,5,5,2,2),
        col = c("blue", "Gainsboro", "Gainsboro","brown", "brown"), lwd = 2)
points(sy1$X, sy1$Y, cex = 1.1, pch = 21, col = "red", bg = "orange")
legend(500,17000,
       c("数据点", "拟合线","预测区间","置信区间"),
       cex = 0.8,
       pch = c(19, NA, NA, NA), lty = c(NA, 1,5, 2),
       col = c("orange", "blue", "Gainsboro", "brown")
)
