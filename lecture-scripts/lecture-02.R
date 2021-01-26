# Make a two-way contingency (frequency) table of sex vs survival status
table(titanic$Sex, titanic$Survived)

# Make one-way tables
table(titanic$Sex)
prob.female <- 288/(288+468)
table(titanic$Survived)
prob.survived <- 313/(443+313)

# Not going to work to calculate P(F and S) since the two events are not independent
prob.female * prob.survived

# This is P(F and S) -- numbers come from the two-way table
217 / (71 + 217 + 372 + 96)
