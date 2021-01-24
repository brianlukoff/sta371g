# Time Series

Let's use the airline passenger example from class:

	air_passengers <- read.csv("https://raw.githubusercontent.com/brianlukoff/sta371g/master/data/air_passengers.csv")
	
First, we convert the data into a time series object in R, and call the resulting object `air`:

	air <- ts(air_passengers$number, start=c(1949, 1), frequency=4)
	
The `frequency` parameter tells R that we have 4 observations per year, and the `start` parameter tells R that the data starts in year 1949, quarter 1.

## Autoregression

We can use the autocorrelation function to pick out significant correlations between the function and its lags. The blue dotted line indicates the boundary line of significance:

	acf(air)
	
Suppose we want to predict air passengers in a quarter from the most recent 4 quarters. First we create a data set that combines the original time series together with the 4 lags:

	dataset <- cbind(air=air, air1=lag(air, -1), air2=lag(air, -2), air3=lag(air, -3), air4=lag(air, -4))
	
Then we can run a regression predicting the time series from the 4 lags:

	model <- lm(air ~ air1 + air2 + air3 + air4, data=dataset)
	
## Stationarity

To check if a series is stationary, we used the Augmented Dickey-Fuller Test:

	library(tseries)
	adf.test(air)
	
Remember that the null hypothesis is that the series is non-stationary, so if p < .05 we conclude that the series is stationary.

## Fitting a linear trend

We can also predict a linear trend by predicting Y from t. In this data set, we don't have a variable that represents t by itself (we have both `year` and `quarter` instead). In R we can get a variable that represents t via the command `time(air)`; this gives a variable where e.g. 1952 indicates Q1 of 1952, 1952.5 indicates Q2 of 1952, etc. Then we can fit a regular regression:

	model <- lm(air ~ time(air))
	
Note that we don't need a `data` parameter since we defined `air` as a variable outside of a data set. 

When interpreting the results, remember that an increase of 1 in the x-variable `time(air)` represents an increase of one year, not one quarter.

## Moving averages

To compute a moving average, we can just average the most recent lag variables. For example, for a moving average with a span of 4:

	air.ma <- (lag(air, -1) + lag(air, -2) + lag(air, -3) + lag(air, -4))/4
	
## Exponential smoothing

For simple exponential smoothing with alpha = 0.5:

	library(forecast)
	air.ses <- ses(air, alpha=0.5)
	
Omitting the `alpha` parameter directs R to select the "optimal" alpha by minimizing prediction error on your data.

We can also use Holt's method, or Holt-Winters' method (the latter is most appropriate for this data set since there is both a trend and seasonality). Holt requires a `beta` parameter and Holt-Winters additionally requires a `gamma` parameter (omit any of these to have R select the parameters).

	air.holt <- holt(air, alpha=0.2, beta=0.1)
	air.holt.winters <- hw(air, alpha=0.2, beta=0.1, gamma=0.1)
	
For any of these forecast methods, view the numerical predictions and confidence intervals by inspecting the variable, and view a graphical representation by plotting it, for example:

	air.ses
	plot(air.ses)
