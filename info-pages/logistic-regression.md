# Logistic regression

Let's do an analysis based on the Titanic data from class. First, we'll load the data and call it `titanic`:

	titanic <- read.csv("https://raw.githubusercontent.com/brianlukoff/sta371g/master/data/titanic.csv")
	
Now let's predict the log odds of survival based on both age and the fare paid:

	model <- glm(survived ~ age + fare, data=titanic, family=binomial)
	
To look at the results, we can use `summary(model)` just like with linear regression.  Note that to do logistic regression:

- we use `glm` instead of `lm` 
- we specify `family=binomial` as a parameter to the `glm` function
- the response variable is binary (categorical, with two levels/factors), coded as 1 for success and 0 for failure

If our data contained a response variable with labels (e.g., suppose we had a dataset called `survey` with a variable `gender` containing values `Male` and `Female`), we could create a dummy variable version using `ifelse`:

	genderMale <- ifelse(survey$gender == "Male", 1, 0)

## Making predictions
	
To make a prediction, we can use the `predict` (or `predict.glm`) command. For example, let's predict the probability of survival for a 40-year old that paid £30 for their ticket:

	predict(model, list(age=40, fare=30), type="response")

The `type=response` is there to tell R that we want to predict probability, not log odds (which is what R will predict without the `type=response` present).

## Evaluating model fit

We can compute pseudo-R<sup>2</sup> manually using the residual and null deviance in the regression output.

To compute the percentage of the cases correctly predicted by the model, first we generate predictions by selecting a cutoff predicted probability (e.g., 0.5) and predicting survival for those people that have a predicted probability of survival of at least 0.5:

	predicted.survived <- (predict(model, type="response") >= 0.5)
	
This variable will be `TRUE` for people that have a predicted probability of survival of at least 0.5, and `FALSE` otherwise.

Then we obtain the actual values for `survived`, and convert 0 to `FALSE` and 1 to `TRUE`:

	actual.survived <- (titanic$survived == 1)
	
Finally, we compute the fraction of the cases where the predicted survival status matches the actual survival status:

	sum(predicted.survived == actual.survived) / nrow(titanic)
	
This formula relies on an R trick: if you have a vector of `TRUE` and `FALSE` values and you `sum` it, then `TRUE` will be interpreted as 1 and `FALSE` as 0, so the sum simply counts the `TRUE`s, i.e., the people for whom we predicted correctly.  `nrow(titanic)` just gives the total number of cases in the data set.

## Hypothesis testing

We can test hypotheses that individual coefficients are 0 (in the population) by looking at the p-values in the output, just as with linear regression. To test the overall null hypothesis that all non-intercept coefficients are 0 (in the population), we have to do a likelihood ratio test. First we define a "null" model with no variables, and compare it against our full model.

	library(lmtest)
	null <- glm(survived ~ 1, data=titanic, family=binomial)
	lrtest(null, model)
	
## Checking the linearity assumption

An empirical logit plot can be used to check the linearity assumption that there is a linear relationship between log odds and the predicted log odds. The R code below defines a function `empirical.logit.plot` that takes a `model` variable and calculates an empirical logit plot. 

```r
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
```

Copy and paste this code into an R script; once you have run this code to define the function, run `empirical.logit.plot(model)` to generate the plot for a model called `model`.