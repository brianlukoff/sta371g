houses <- read.csv("https://raw.githubusercontent.com/brianlukoff/sta371g/master/data/houses.csv")
nba <- read.csv("https://raw.githubusercontent.com/brianlukoff/sta371g/master/data/nba.csv")

model <- lm(PTS ~ PCT3P + N3PA, data=nba)
summary(model)
plot(model)
