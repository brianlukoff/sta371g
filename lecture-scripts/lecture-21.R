mystery <- read.csv("https://raw.githubusercontent.com/brianlukoff/sta371g/master/data/mystery.csv")

model <- lm(Y ~ ., data=mystery)
summary(model)

model2 <- lm(Y ~ X10 + X13 + X16, data=mystery)
summary(model2)
