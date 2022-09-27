# Experiment Report 2

## question 1
st.calculate <- function(x){
        result <- c("均值" = mean(x), "方差" = var(x), 
                    "最大值" = max(x), "最小值" = min(x))
        return(result)
}

## question 2
prime <- function(num){
        p <- c(2)
        for(i in 2:num){
                flag <- 2:(i-1)
                result <- i%%flag
                if(length(which(result==0))==0){
                        p <- c(p,i)
                }
                
        }
        return(p)
        
}

## question 3 
fibo <- function(num){
        fib <- c(1,1)
        if(num >= 2){
                for(i in 1:num){
                        fib[i+2] = fib[i+1] + fib[i]
                }
                return(fib)     
        } else if(num == 0){return(fib[1])} else {return(fib)}
}

## question 4
guess <- function(times = 7){
        random <- round(runif(1, 1, 100))
        while(times>=0){
                x<-as.numeric(readline("guess number: "))
                if(x > random){
                        print("High")
                } else if(x < random){
                        print("Low")
                } else {
                        print("You won!")
                        break
                }
                times <- times - 1
        }
}


## question 5
samplem <- function(x){
        a <- mean(x)
        b <- var(x)
        c <- c(a,b)
        return(c)
}

skew <- function(x){
        s <- mean(((x-mean(x))/sd(x))^3)
        return(s)
}

## https://www.cnblogs.com/freebird92/p/5177867.html
