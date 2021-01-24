# Model selection

Let's use the baseball data set from class, where we'll predict `AVG` (batting average):

	baseball <- read.csv("https://raw.githubusercontent.com/brianlukoff/sta371g/master/data/baseball.csv")

## Stepwise regression

We can do both forward and backward stepwise regression using the `step` function. First we define a "null" model with no predictor variables, as a base for R to build on (or fall back on, if it turns out that none of the predictor variables are worth keeping!), and a "full" model that contains all of the predictors we want to consider:

	null <- lm(AVG ~ 1, data=baseball)
	full <- lm(AVG ~ OBP + SLG + EXP + PAYR + MLAVG + MLOBP + MLSLG + AVGcumLag1 + OBPcumLag1 + SLGcumLag1 + G + YRINDEX, data=baseball)
	
Now we can do forward stepwise regression, starting at `null`:

	step(null, scope=list(lower=null, upper=full), direction="forward")
	
Or backward stepwise regression, starting at `full`:

	step(full, scope=list(lower=null, upper=full), direction="backward")
	
## Best-subsets regression

The `regsubsets` command runs best subsets regression; the syntax is similar to `lm`. However, we first have to load the `leaps` library (if you get an error when you try to run the `library` command below, first run `install.packages("leaps")` and then re-run it; you'll only have to do that once).

	library(leaps)
	results <- regsubsets(AVG ~ OBP + SLG + EXP + PAYR + MLAVG + MLOBP + MLSLG + AVGcumLag1 + OBPcumLag1 + SLGcumLag1 + G + YRINDEX, data=baseball)
	
The results can be plotted against a number of different selection metrics:

	plot(results, scale="adjr2")
	plot(results, scale="bic")