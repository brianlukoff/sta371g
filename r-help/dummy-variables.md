# Dummy variables

Let's use the fuel economy data from class. First, we'll load the data:

	auto_mpg_all <- read.csv("https://raw.githubusercontent.com/brianlukoff/sta371g/master/data/auto_mpg_all.csv")
	
There are two ways to include the Yes/No categorical variable `After1975` in the regression. One way is to create our own dummy variable that recodes Yes to 1 and No to 0 (or vice versa), and then run a regression including that dummy variable:

	auto_mpg$LateModel <- ifelse(auto_mpg$After1975 == "Yes", 1, 0)
	model1 <- lm(MPG ~ HP + LateModel, data=auto_mpg_all)
	summary(model1)
	
We can also let R do the heavy lifting for us; by using `After1975` directly in the `lm` command, R creates a dummy variable behind the scenes:

	model2 <- lm(MPG ~ HP + After1975, data=auto_mpg_all)
	summary(model2)
	
Note that the output refers to a new variable called `After1975Yes`; this is a dummy variable where 1 is Yes and 0 is No.

We can do the same with categorical variables that have 3+ categories. For example, suppose we want to include the `Origin` variable in the model. Add it to the `lm` command, and R will automatically create dummy variables for all but one of the categories and add them to the model:

	model3 <- lm(MPG ~ HP + Origin, data=auto_mpg_all)
	summary(model3)
	
If we want to test the significance of the `Origin` variable, we must use an ANOVA table to test a compound null hypothesis that all of the dummy variable coefficients for that particular categorical variable are 0 in the population.  To do this, first ensure that your model is defined with the categorical variable of interest (`Origin` in this case) is at the *end* of the list of variables, and then run the `anova` command:

	model3 <- lm(MPG ~ HP + Origin, data=auto_mpg_all)
	anova(model3)