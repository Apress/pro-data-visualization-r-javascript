
print("Hello World")

alpha <- c("A", "B", "C", "D", "E") 

n <- c(20,30,40,50,60)
n * 4 

l <- list()
l$name <- "Cards"
l$cards <- c("10","Jack","Queen","King","Ace")
l$bets <- c(1,5,10) 

sex <- factor(c("male","female","unknown","male")) 
sex 

my_fun <- function(x, y) {
  r = x * 2 + y
  r 
}

my_fun(3, 189)

state <- "startup" 
if(state == "startup") {
  print("We are about to start the program")
  state = "running program" 
} else {
  print("Program running") 
}

ifelse(state == "startup", TRUE, FALSE) 

for (i in 1:5){
  print(i)
} 

i <- 1 
while (i <= 5) { 
  print(i) 
  i <- i + 1 
}

lapply(n, function(i){
  i * i
})

sapply(n, function(i){
  i * i
})





