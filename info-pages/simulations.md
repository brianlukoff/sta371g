# Simulations

## Basic simulation structure

To run a simulation and capture a number as the result of each simulation run, use `replicate`. For example, suppose we want to estimate the mean of the sum of two normal distributions by selecting a random number from two normal distributions in each run, and then taking the mean of each sum:

	results <- replicate(10000, {
		number1 <- rnorm(1, mean=0, sd=1)
		number2 <- rnorm(1, mean=0, sd=1)
		number1 + number2
	})
	mean(results)
	
Note that the last line of the `replicate` code block (before the `}`) will be used as the value extracted from the simulation.

## Selecting a number at random

Use the `sample` command. For example, to select from among the numbers {1, 2, 3} 10 times, use

	sample(c(1, 2, 3), 10, replace=T)
	
The `replace=T` ensures that the selected number is put back into the list before the next number is sampled. Each number has an equal probability of being selected.


## Counting

If you apply the `sum` command to a list of `TRUE`/`FALSE` values, R will count the number of `TRUE` values in the list. To produce such a list, write down a logical statement about a list. So, for example, this will count the number of positive values in the list:

	list <- c(4, -2, 5, 9, -3)
	sum(list > 0)
	
The result will be 3. To find the percentage of positive values in the list:

	list <- c(4, -2, 5, 9, -3)
	sum(list > 0) / length(list)

## Conditional statements

Use `if` and `else` to branch based on a condition. For example, the following outputs `1`:

	value <- 6
	if (value > 0) {
		result <- 1
	} else {
		result <- -1
	}
	result
	
## Keeping track of running tallies

To run something a certain number of times and keep track of a running tally, use a `for` loop rather than `replicate`. For example, let's say we want to add up the numbers 1 through 100:

	total <- j
	for (j in 1:100) {
		total <- total + j
	}
	total
	
What's inside the `for` loop will be run 100 times. The first time, `j` will be set to 1; the second time, `j` will be set to 2; etc. The final time, `j` will be set to 100. 
	
## Selecting random numbers from different distributions

To select a value at random from a normal distribution, use `rnorm`. For example, to select a single number at random from a normal distribution with mean 100 and SD 15:

	rnorm(1, 100, 15)
	
Or select 10 such numbers:

	rnorm(10, 100, 15)
	
There are equivalent commands for other distributions. For example, `runif` draws from a uniform distribution, and `rgamma` draws from a Gamma distribution. To get information on how these commands work, type `?runif` and `?rgamma` at the R command line.

## Simulating an event

To simulate an event with a certain probability, draw a number from a random uniform distribution on [0, 1] (use `runif(1)` or, equivalently, `runif(1, min=0, max=1)` and test to see if it is below the given probability:

	if (runif(1) < 0.3) {
		# This part will be executed 30% of the time
	} else {
		# This part will be executed 70% of the time
	}
