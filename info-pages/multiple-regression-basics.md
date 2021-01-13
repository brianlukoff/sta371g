# Multiple regression basics

Let's do some regression analyses of the Boston home price data. First, we'll load the data set and call it `boston`:

	boston <- read.csv("https://raw.githubusercontent.com/brianlukoff/sta371g/master/data/boston.csv")

Now let's run a regression model predicting median home price (MEDV) from number of rooms (ROOM) and percentage of "lower status" in the population (LSTAT):

	model <- lm(MEDV ~ LSTAT + ROOM, data=boston)

As with a simple regression, we can view the full output by viewing the summary:

	summary(model)

As with simple regression, we can make a prediction of median home price by entering values for each of the predictors:

	predict.lm(model, list(LSTAT=0.5, ROOM=5))

Adding `interval="confidence` or `interval="prediction"` before the final parenthesis above will generate 95% confidence intervals for the mean Y or for a single new prediction, respectively. To get confidence intervals for the coefficients themselves, we use the same command as with simple regression:

	confint(model)

To check assumptions, we can create plots similar to what we used for simple regression. To check Assumptions 2 & 4 (linearity and homoscedasticity), we create a plot of residuals vs predicted values:

	plot(predict.lm(model), resid(model))

Here we're looking for a plot that shows no trend and roughly vertical "thickness" all the way across. (In fact, there is a trend here, suggesting that in fact the linearity assumption is violated in this model!)

To check Assumption 3 (normality of residuals), we can create a histogram and Q-Q plot of the residuals, as we did before:

	hist(resid(model))  
	qqnorm(model)

As in simple regression, we're looking for a roughly straight line, which we have here.
