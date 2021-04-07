install.packages("car")

counties <- read.csv("https://raw.githubusercontent.com/brianlukoff/sta371g/master/data/counties.csv")

summary(lm(Physicians ~ Population, data=counties))

model1 <- lm(PhysiciansPer10000 ~ LandArea + PctRural + MedianIncome +
              PctUnder18 + PctOver65 + PctPoverty + PctUninsured +
              PctSomeCollege + PctUnemployed + Population, data=counties)
summary(model1)

model2 <- lm(PhysiciansPer10000 ~ LandArea + PctRural + 
               PctUnder18 + PctOver65 + PctPoverty + PctUninsured +
               PctSomeCollege + PctUnemployed + Population, data=counties)
summary(model2)

model3 <- lm(PhysiciansPer10000 ~ LandArea + PctRural + 
               PctUnder18 + PctOver65 + PctPoverty + 
               PctSomeCollege + PctUnemployed + Population, data=counties)
summary(model3)

model4 <- lm(PhysiciansPer10000 ~ LandArea + PctRural + 
               PctUnder18 + PctOver65 + 
               PctSomeCollege + PctUnemployed + Population, data=counties)
summary(model4)

model5 <- lm(PhysiciansPer10000 ~ LandArea + PctRural + 
               PctOver65 + 
               PctSomeCollege + PctUnemployed + Population, data=counties)
summary(model5)

model6 <- lm(PhysiciansPer10000 ~ PctRural + 
               PctOver65 + 
               PctSomeCollege + PctUnemployed + Population, data=counties)
summary(model6)

model7 <- lm(PhysiciansPer10000 ~ PctRural + 
               PctOver65 + 
               PctSomeCollege + PctUnemployed, data=counties)
summary(model7)

model8 <- lm(PhysiciansPer10000 ~ PctRural + 
               PctOver65 + 
               PctSomeCollege, data=counties)
summary(model8)


