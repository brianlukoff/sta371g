# Loading and saving data

## Loading data

There are two ways to load files. The easiest is to load it directly from GitHub:

1.  [Go to the GitHub web site for our course](https://github.com/brianlukoff/sta371g)
2.  Click the **data** folder, and then click on a data set (we'll use `stock_market_returns.csv` as an example).
3.  GitHub by default will show you the data in their viewer, but we need the link directly to the file itself, so click on **Raw** on the right.
4.  Copy the URL to the clipboard and then paste into an R command in the following format:

    	stock_market_returns <- read.csv("https://raw.githubusercontent.com/brianlukoff/sta371g/master/data/stock_market_returns.csv")

5.  Once you run this command, the data will be loaded into the data frame you specified in R (whatever you put to the left of the arrow; in this case, `stock_market_returns`).

As an alternative, you can save the raw CSV file to your computer, and use the **Import Dataset** button in RStudio to load it.

## Saving data

If you have loaded data from GitHub, you can save it as a CSV file on your computer so you can load it in the future without having to download it again. Once you have loaded the data, you can save it to a file with a command like the following:

	write.csv(stock_market_returns, "~/Desktop/returns.csv")

The part in quotes should be the path to the file you want to save on your computer (on a Mac, this would save to a file called **returns.csv** on the desktop). This file can later be reopened in R via **Import Dataset**.