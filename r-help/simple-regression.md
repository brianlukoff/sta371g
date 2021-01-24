# Simple regression

Let's replicate the stock beta analysis from class. First, we'll load the data. If you have the CSV saved on your computer, use the **Import Dataset** button in RStudio. We'll load it straight from GitHub into a variable called `stock_market_returns`:

	stock_market_returns <- read.csv("https://raw.githubusercontent.com/brianlukoff/sta371g/master/data/stock_market_returns.csv", header=T)

First let's do some exploratory data analysis. We can create a histogram:

	hist(stock_market_returns$W5000)

To beautify any plot, we can add optional parameters to change the color (col), add an x-axis (xlab) or y-axis (ylab) label, or add a title at the top (main). For example:

	hist(stock_market_returns$W5000, col='green', main='Histogram of W5000 returns', xlab='W5000 return as a % of previous week close')

We can also make a scatterplot:

	plot(AMZN ~ W5000, data=stock_market_returns, pch=16, col='cyan')

Note that the form of the formula on the left is Y ~ X. The "pch=16" uses filled-circles to plot the data points. The data parameter tells R what data frame to pull the variables AMZN and W5000 from.

Since AMZN and W5000 look linearly related, you may want to examine the correlation. To see the correlation, use the cor function:

	cor(data$AMZN, data$W5000)

Now let's run a regression predicting AMZN returns from W5000 returns, and assign the result to a variable called model:

	model <- lm(AMZN ~ W5000, data=stock_market_returns)

Running this command won't yield any output; the output of the regression has been stored in the variable model. To see the results, use the summary function:

	summary(model)

We can also visualize the regression line by drawing it on top of a scatterplot:

	plot(AMZN ~ W5000, data=stock_market_returns)  
	abline(model)

Now let's do some prediction. Rather than doing the calculations ourselves, we can ask R to predict Y based on a specific value of X. For example, let's predict the AMZN return if the W5000 return is 1%:

	predict.lm(model, list(W5000=1))

We can even get a confidence interval for the mean (i.e., a confidence interval for the average AMZN return over a long period of time):

	predict.lm(model, list(W5000=1), interval="confidence")

<span>Or a prediction interval (i.e., a confidence interval for the AMZN return for a particular week where the W5000 return is 1%):</span>

	predict.lm(model, list(W5000=1), interval="prediction")

Finally, we can get confidence intervals on the estimates for each of the coefficients:

	confint(model)

To verify regression assumptions, we can create a plot of fitted vs X values:

	plot(stock_market_returns$W5000, resid(model))

Note the slightly different form of the plot command here. Earlier, we plotted a "formula" by specifying it in the format `Y ~ X`, and indicating what data frame the variables were to be drawn from (`stock_market_returns`). Here, we just tell R to plot one variable against another, so we just give the plot command the two variables separated by a comma (X first). The first variable extracts the `W5000` variable from the `stock_market_returns` using the dollar sign, and the second takes the residuals of the regression model we computed earlier.

We can also examine the residuals to check for normality:

	hist(resid(model))  
	qqnorm(resid(model))