cars <- read.csv("https://raw.githubusercontent.com/brianlukoff/sta371g/master/data/cars.csv")
plot(cars$Weight, cars$MPG)
model <- lm(MPG ~ Weight, data=cars)
plot(cars$Weight, residuals(model))
qqnorm(residuals(model))

plot(model)

cars$LogWeight <- log(cars$Weight)
log.model <- lm(MPG ~ LogWeight, data=cars)
plot(cars$LogWeight, residuals(log.model))

summary(log.model)
# Predicted MPG = 209.9433 - 23.4317*log(Weight)
209.9433 - 23.4317*log(3000)

cars$LogMPG <- log(cars$MPG)
log.log.model <- lm(LogMPG ~ LogWeight, data=cars)
plot(cars$LogWeight, residuals(log.log.model))
summary(log.log.model)
# Predicted log(MPG) = 11.5152 - 1.0575*log(Weight)
# Predicted log(MPG) when Weight = 3000:
11.5152 - 1.0575*log(3000)
# Predicted MPG when Weight = 3000:
exp(11.5152 - 1.0575*log(3000))

cars$rMPG <- 1/cars$MPG
recip.model <- lm(rMPG ~ Weight, data=cars)
plot(cars$Weight, residuals(recip.model))
summary(recip.model)
# Predicted 1/MPG = -3.803e-03 + (1.734e-05)*Weight
# Predicted 1/MPG when Weight = 3000:
-3.803e-03 + (1.734e-05)*3000
# Predicted MPG when Weight = 3000:
1/(-3.803e-03 + (1.734e-05)*3000)

chips <- read.csv("https://raw.githubusercontent.com/brianlukoff/sta371g/master/data/chips.csv")
plot(chips$Date.of.introduction, chips$Transistor.count)
plot(chips$Date.of.introduction, 1/chips$Transistor.count)
plot(chips$Date.of.introduction, log(chips$Transistor.count))
plot(log(chips$Date.of.introduction), chips$Transistor.count)
plot(1/chips$Date.of.introduction, chips$Transistor.count)
chip.model <- lm(log(Transistor.count) ~ Date.of.introduction, data=chips)
plot(chips$Date.of.introduction, residuals(chip.model))
