houses <- read.csv("https://raw.githubusercontent.com/brianlukoff/sta371g/master/data/houses.csv")

.3*1728
1:1728
set.seed(1)
test.cases <- sample(1:1728, 518)
test.set <- houses[test.cases,]
training.cases <- setdiff(1:1728, test.cases)
training.set <- houses[training.cases,]

abs(mean(training.set$Price) - mean(test.set$Price))

model <- lm(Price ~ Living.Area, data=training.set)
# mean absolute error (MAE) on the training set
mean(abs(residuals(model)))
# mean absolute error (MAE) on the test set
predicted.prices <- predict(model, test.set)
mean(abs(predicted.prices - test.set$Price))


summary(lm(Price ~ Lot.Size + Waterfront + Land.Value + Fuel.Type + Living.Area, data=training.set))
summary(lm(Price ~ Lot.Size + Waterfront + Land.Value + Living.Area, data=training.set))
summary(lm(Price ~ Waterfront + Land.Value + Living.Area, data=training.set))
summary(lm(Price ~ Land.Value + Living.Area, data=training.set))  # <====
summary(lm(Price ~ Living.Area, data=training.set))

model2 <- lm(Price ~ Land.Value + Living.Area, data=training.set)
# MAE on the training set
mean(abs(residuals(model2)))
# MAE on the test set
predicted.prices <- predict(model2, test.set)
mean(abs(predicted.prices - test.set$Price))

# R^2 on test set
cor(predicted.prices, test.set$Price)^2
