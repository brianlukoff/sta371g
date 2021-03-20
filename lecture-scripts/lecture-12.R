stock.market <- read.csv("https://raw.githubusercontent.com/brianlukoff/sta371g/master/data/stock-market-returns.csv")

amzn.model <- lm(AMZN ~ W5000, data=stock.market)
bac.model <- lm(BAC ~ W5000, data=stock.market)
pg.model <- lm(PG ~ W5000, data=stock.market)
sbux.model <- lm(SBUX ~ W5000, data=stock.market)
summary(amzn.model) # beta = 1.13
summary(bac.model)  # beta = 1.44
summary(pg.model)   # beta = 0.45
summary(sbux.model) # beta = 0.70

plot(BAC ~ W5000, data=stock.market)
abline(bac.model)
plot(PG ~ W5000, data=stock.market)
abline(pg.model)

plot(stock.market$W5000, residuals(pg.model))
hist(residuals(pg.model))
qqnorm(residuals(pg.model))
