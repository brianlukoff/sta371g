ut2000 <- read.csv("http://jgscott.github.io/teaching/data/ut2000.csv")
hist(ut2000$GPA)
mysample <- sample(ut2000$GPA, 100)
# sample mean
mean(mysample)
# population mean
mean(ut2000$GPA)

sample.means <- replicate(100000, {
  mysample <- sample(ut2000$GPA, 100)
  # sample mean
  mean(mysample)
})
hist(sample.means, breaks=5)
