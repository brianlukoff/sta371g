addhealth <- read.csv("https://raw.githubusercontent.com/brianlukoff/sta371g/master/data/addhealth.csv")

drinking <- data.frame(age=addhealth$h4to34, 
                       num.drinks=addhealth$h4to36)

hist(drinking$age)
table(drinking$age)
drinking$age[drinking$age >= 96] <- NA

hist(drinking$num.drinks)
drinking$num.drinks[drinking$num.drinks >= 96] <- NA

plot(drinking$age, drinking$num.drinks)
model <- lm(num.drinks ~ age, data=drinking)
abline(model)

summary(model)

options(scipen=20)

confint(model)
confint(model, level=0.99)

-0.16883*21 + 6.55417  
predict(model, list(age=21))
