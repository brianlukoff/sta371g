dell <- read.csv("https://raw.githubusercontent.com/brianlukoff/sta371g/master/data/dell.csv")

model <- lm(Close ~ Day, data=dell)
plot(dell$Day, residuals(model))
summary(model)

plot(Close ~ Day, data=dell)
abline(model)

plot(model)

# Only need to do this once
install.packages("lmtest")
# Do this every time (at the beginning of your R session where you want to use dwtest)
library(lmtest)

dwtest(model)
