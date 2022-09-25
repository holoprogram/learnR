library(readxl)
wp <- read_xlsx("waterpollution.xlsx", sheet = 1)
names(wp) <- c("Y", "X1","X2","X3","X4")
lm.sol <- lm(Y~1+X1+X2+X3+X4, data = wp)
summary(lm.sol)
cor(wp$Y, wp$X1)
cor(wp$Y, wp$X2)
cor(wp$Y, wp$X3)
cor(wp$Y, wp$X4)


