set.seed(1234567890)
install.packages("neuralnet")
library(neuralnet)

dataset <- read.csv("RCreditAnalysis/creditset.csv")
head(dataset)

trainset <- dataset[1:800, ]s

testset <- dataset[801:2000, ]

creditnet <- neuralnet(default10yr ~ LTI + age, trainset, hidden = 4,
                       lifesign = "minimal", linear.output = FALSE, threshold = 0.1)

plot(creditnet, rep = "best")

temp_test <- subset(testset, select = c("LTI", "age"))
creditnet.results <- compute(creditnet, temp_test)
head(temp_test)

results <- data.frame(actual = testset$default10yr, prediction =
                        creditnet.results$net.result)
results[100:115, ]

results$prediction <- round(results$prediction)
results[100:115, ]

