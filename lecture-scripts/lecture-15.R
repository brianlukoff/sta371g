colleges <- read.csv("https://raw.githubusercontent.com/brianlukoff/sta371g/master/data/colleges.csv")

my.sample <- subset(colleges, Graduation.rate <= 100 &
                      !is.na(Average.combined.SAT))

summary(lm(Graduation.rate ~ Average.combined.SAT, data=my.sample))
summary(lm(Graduation.rate ~ Acceptance.rate, data=my.sample))
summary(lm(Graduation.rate ~ Pct.students.top.10.HS, data=my.sample))
summary(lm(Graduation.rate ~ In.state.tuition, data=my.sample))

model <- lm(Graduation.rate ~ Average.combined.SAT + In.state.tuition, data=my.sample)
summary(model)

# Prediction for UT
-8.3246456 + 0.0611221*1126 + 0.0012486*840
predict(model, list(Average.combined.SAT=1126, In.state.tuition=840))
predict(model, list(Average.combined.SAT=1226, In.state.tuition=840))
67.65988 - 61.54767

summary(lm(Graduation.rate ~ Acceptance.rate, data=my.sample))
plot(Graduation.rate ~ Acceptance.rate, data=my.sample)
options(scipen=20)

summary(lm(Graduation.rate ~ Acceptance.rate + Average.combined.SAT, data=my.sample))
predict(model)

model2 <- lm(Graduation.rate ~ In.state.tuition + Out.of.state.tuition +
               Full.time.students + Part.time.students, data=my.sample)
plot(predict(model2), residuals(model2))
qqnorm(residuals(model2))
plot(model2)
