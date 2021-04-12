nba <- read.csv("https://raw.githubusercontent.com/brianlukoff/sta371g/master/data/nba.csv")

install.packages("okcupiddata")
library(okcupiddata)
profiles
View(profiles)

profiles$male <- ifelse(profiles$sex == "m", 1, 0)

my.profiles <- subset(profiles, height >= 55 & height <= 80)

model <- glm(male ~ height, data=my.profiles, family="binomial")

-44.45 + .66*69
exp(1.09) / (1 + exp(1.09))

summary(model)

predictions <- predict(model, type="response")
ifelse(predictions >= 0.5, 1, 0)
