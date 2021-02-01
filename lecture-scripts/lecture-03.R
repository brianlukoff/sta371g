mytable <- table(titanic$Sex, titanic$Survived)
addmargins(mytable)

# Percentages of overall total # of cases
prop.table(mytable)
# Percentages of the row totals
prop.table(mytable, 1)
# Percentages of the column totals
prop.table(mytable, 2)

table(titanic$PClass, titanic$Sex)
prop.table(table(titanic$PClass, titanic$Sex), 1)
prop.table(table(titanic$Sex))

# P(S|F) = proportion of women that survived
217/288

prop.table(table(titanic$Sex, titanic$Survived), 2)
table(titanic$Survived, titanic$Sex)

prop.table(table(titanic$Sex, titanic$PClass), 1)
prop.table(table(titanic$Sex))
