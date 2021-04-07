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
