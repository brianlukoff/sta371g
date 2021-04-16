library(okcupiddata)
View(profiles)

profiles$male <- ifelse(profiles$sex == "m", 1, 0)
my.profiles <- subset(profiles, height >= 55 & height <= 80)
model <- glm(male ~ height, data=my.profiles, family="binomial")
summary(model)

predict(model, list(height=60), type="response")
predict(model, list(height=70), type="response")
predict(model, list(height=67), type="response")

44.45/.66
predict(model, list(height=67.34848), type="response")

predicted.male <- (predict(model, type="response") >= 0.5)
actual.male <- (my.profiles$male == 1)
# (number of correct predictions) / (total number of people in the data set)
sum(predicted.male == actual.male) / nrow(my.profiles)

table(my.profiles$male)
35737/59826
sum(actual.male) / nrow(my.profiles)

empirical.logit.plot <- function(model, breaks=10, lwd=3, linecol="orange", col="lightblue") {
  # Segment predicted log odds into buckets of 10% each (if possible)
  percentiles <- unique(quantile(predict(model), probs=seq(0, 1, 1/breaks)))
  data <- data.frame(predicted.logits=predict(model), 
                     y=model$model[,1],
                     groups=cut(predict(model), breaks=percentiles, labels=F))
  # Within each group, calculate actual number of successes and number of cases
  num.success <- table(data$y, data$groups)["1",]
  num.cases <- as.numeric(table(data$groups))
  # Calculate empirical probability within each group, with a small
  # adjustment to avoid infinity when p = 1
  empirical.probs <- (num.success + 0.5) / (num.cases + 1)
  # Calculate actual log odds within each group
  logits <- log(empirical.probs / (1 - empirical.probs))
  # Find the mean predicted log odds within each group
  bins <- aggregate(predicted.logits ~ groups, data=data, mean, drop=F)[,2]
  # Within each bin, plot predicted log odds (based on the model)
  # versus the actual log odds for all cases in that bin
  plot(logits ~ bins, pch=16, xlab="Predicted log odds", 
       ylab="Empirical log odds", col=col, pty="s")
  # Overlay the line y = x on top of the plot
  abline(a=0, b=1, lwd=lwd, col=linecol)
}

empirical.logit.plot(model)

model2 <- glm(male ~ income, data=my.profiles, family="binomial")
summary(model2)
empirical.logit.plot(model2)

model3 <- glm(male ~ height + orientation, data=my.profiles, family="binomial")
summary(model3)
