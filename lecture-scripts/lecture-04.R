# Bayes Rule
# P(A|B) = P(B|A)P(A) / (P(B|A)P(A) + P(B|A^c)P(A^c))

# Looking for: P(C^c|T^c)
# = P(T^c|C^c)P(C^c) / (P(T^c|C^c)P(C^c) + P(T^c|C)P(C))

# P(T^c|C^c) = 0.996
# P(C^c) = 0.9
# P(T^c|C) = 100% - 96.8% = 0.032 = 1 - P(T|C)
# P(C) = 0.1

(0.996*0.9) / (0.996*0.9 + 0.032*0.1)

prices <- c(799, 999, 1099, 699)
probs <- c(0.35, 0.29, 0.28, 0.08)
# Expected value
expected.value <- sum(prices * probs)
# Variance
variance <- sum((prices - expected.value)^2 * probs)
# Standard deviation
sqrt(variance)

newprices <- c(799, 999, 1099, 699)
newprobs <- c(0.43, 0.29, 0.28, 0)
sum(newprices * newprobs)

ut2000 <- read.csv("http://jgscott.github.io/teaching/data/ut2000.csv")
hist(ut2000$SAT.C)
