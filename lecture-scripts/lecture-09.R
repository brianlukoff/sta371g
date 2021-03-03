ut2000 <- read.csv("http://jgscott.github.io/teaching/data/ut2000.csv")
cor(ut2000$GPA, ut2000$SAT.C)
cor(ut2000$GPA + 1, ut2000$SAT.C)

addhealth <- read.csv("https://raw.githubusercontent.com/brianlukoff/sta371g/master/data/addhealth.csv")


drinking <- data.frame(age=addhealth$h4to34, num.drinks=addhealth$h4to36)
hist(drinking$age)
table(drinking$age)
drinking$age[drinking$age >= 96] <- NA

hist(drinking$num.drinks)
drinking$num.drinks[drinking$num.drinks >= 96] <- NA
