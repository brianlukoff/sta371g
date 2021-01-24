# Interactions

Let's replicate the fireplace/housing price example from class. First, let's load the data:

	houses <- read.csv("https://raw.githubusercontent.com/brianlukoff/sta371g/master/data/houses.csv")
	
Now let's run a regression predicting house price from living space and whether the house has a fireplace:

	model1 <- lm(Price ~ Living.Area + Fireplace, data=houses)
	summary(model1)
	
Note that R automatically creates FireplaceYes as a dummy variable and adds it to the model. 

Now let's add an interaction term between `Fireplace` and `Living.Area`:

	model2 <- lm(Price ~ Living.Area * Fireplace, data=houses)
	summary(model2)
	
Note that by specifying the formula as `Living.Area * Fireplace`, R automatically includes both main effects plus the interaction effect.