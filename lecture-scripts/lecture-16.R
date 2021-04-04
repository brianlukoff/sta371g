colleges <- read.csv("https://raw.githubusercontent.com/brianlukoff/sta371g/master/data/colleges.csv")
my.sample <- subset(colleges, Graduation.rate <= 100 &
                      !is.na(Average.combined.SAT))
model <- lm(Graduation.rate ~ Average.combined.SAT + In.state.tuition, data=my.sample)
summary(model)
# Predicted grad rate = -8.32 + 0.0611*SAT + 0.0012*Tuition

manager <-read.csv("https://raw.githubusercontent.com/brianlukoff/sta371g/master/data/manager.csv", na.strings="")
mclean <- subset(manager, Salary > 0 & Salary < 200)
