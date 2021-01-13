# Diagnostics and transformations

## Transforming variables

To use a transformed variable in your analysis, create a new variable in the same data set that applies the desired function to the original variable, and then use this new variable in place of the original variable in your analysis. 

For example, let's use the MPG/HP case from class:

	auto_mpg <- read.csv("https://raw.githubusercontent.com/brianlukoff/sta371g/master/data/auto_mpg.csv")
	
If we want to predict MPG from log(HP) instead of HP:

	auto_mpg$HP_ln <- log(auto_mpg$HP)
	model <- lm(Price ~ HP_ln, data=auto_mpg)
	
We can do the same with any transformation function (e.g., square root, squaring, exponentiation, etc), and any variable (predictor or response).

## Finding and removing outliers

Let's use the manager salary data from class:

	manager <- read.csv("https://raw.githubusercontent.com/brianlukoff/sta371g/master/data/manager.csv")
	
We can use a box plot to identify outliers. Let's start for looking for outliers in the Salary variable:

	boxplot(manager$Salary)
	
To see the cases in the file that correspond to the outliers, we can use R's indexing notation. For example, in the box plot above it is clear that there is a case with a negative salary. We can find this by asking R for all cases where Salary < 0:

	manager[manager$Salary < 0,]
	
The 121 label on the resulting line tells you that was line 121 of the data file.

To remove the outlier, we can create a new cleaned data set that contains all of the rows *except* the ones we want removed:

	mclean <- manager[manager$Salary > 0,]
	
Now the `mclean` data set contains all rows except the one with a negative salary.

## Missing data

You can find rows with missing data using the `complete.cases` function:

	manager[!complete.cases(manager),]
	
If you just want to omit any rows with missing data, just use `na.omit`:
	
	manager_without_missing_data <- na.omit(manager)
	
To replace missing values for a particular variable (in this case, `MngrRating`) with the average value of that variable, we first calculate the mean of that row (`na.rm=T` ignores the `NA` values when calculating the mean) and then assign it to all rows where that value is `NA`:

	 mclean$MngrRating[is.na(mclean$MngrRating)] <- 
        mean(mclean$MngrRating, na.rm=T)
        
## Multicollinearity

To check for multicollinearity, look at the scatterplots between each (quantitative) predictor to see if any are highly correlated. Here's an example of doing this with the `MngrRating`, `YearsExp`, and `YrsSinceGrad` variables. Note that the formula below does not include a response variable, since we don't care about the correlation between the response variable and the predictors (in fact, it's a good thing if those correlations are high, as it indicates the model will be good a predicting the response!).

	pairs(~ MngrRating + YearsExp + YrsSinceGrad, data=manager)
	
There are more insidious forms of multicollinearity, when no pairs of predictors are particularly highly correlated but one predictor can be predicted well from the others. You could discover this yourself by performing regressions predicting each predictor from the others, but the VIF is an easier way to tell - high VIFs indicate that a variable is highly predicted from the others:

	# Define a model first, i.e. model <- lm(...)
	library(car)
	vif(model)
	
## Influential cases

A single command will generate plots for you to check assumptions, as well as a residual vs leverage plot you can use to identify influential points:

	# Define a model first, i.e. model <- lm(...)
	plot(model)
	
If you need to calculate leverage specifically, you can do so with the `hatvalues` function:

	hatvalues(model)
	
You can then sort the list if you need to figure out which cases have the highest leverage:
	
	sort(hatvalues(model))