addhealth <- read.csv("https://raw.githubusercontent.com/brianlukoff/sta371g/master/data/addhealth.csv")

drinking <- data.frame(age=addhealth$h4to34, num.drinks=addhealth$h4to36)
hist(drinking$age)
table(drinking$age)
drinking$age[drinking$age >= 96] <- NA

hist(drinking$num.drinks)
drinking$num.drinks[drinking$num.drinks >= 96] <- NA

plot(drinking$age, drinking$num.drinks)
model <- lm(num.drinks ~ age, data=drinking)
summary(model)

alex <- predict(model, list(age=20))
beth <- predict(model, list(age=23))
alex - beth
.17*3

stock.market <- read.csv("https://raw.githubusercontent.com/brianlukoff/sta371g/master/data/stock-market-returns.csv")
hist(stock.market$W5000)
hist(stock.market$AMZN)
plot(stock.market$W5000, stock.market$AMZN)

model2 <- lm(AMZN ~ W5000, data=stock.market)
plot(stock.market$W5000, residuals(model2))

abline(model2)
summary(model2)
