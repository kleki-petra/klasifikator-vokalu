library(kernlab)
library(caret)
library(readxl)
library(ggplot2)
library(randomForest)

tab <- read_xlsx("MFCC.xlsx")

tab$c1 <- as.numeric(tab$c1)
tab$c2 <- as.numeric(tab$c2)
tab$c3 <- as.numeric(tab$c3)
tab$c4 <- as.numeric(tab$c4)
tab$c5 <- as.numeric(tab$c5)
tab$c6 <- as.numeric(tab$c6)
tab$c7 <- as.numeric(tab$c7)
tab$c8 <- as.numeric(tab$c8)
tab$c9 <- as.numeric(tab$c9)
tab$c10 <- as.numeric(tab$c10)
tab$c11 <- as.numeric(tab$c11)
tab$c12 <- as.numeric(tab$c12)
tab$trvani <- as.numeric(tab$trvani)

set.seed(3434)
inTrain <- createDataPartition(y=tab$Vowel, p=c(0.6, 0.4), list=FALSE)
training <- tab[inTrain,]
zbytek <- tab[-inTrain,]

inTest <- createDataPartition(y=zbytek$Vowel, p=c(0.5, 0.5), list=FALSE)
validating <- zbytek[inTest,]
testing <- zbytek[-inTest,]

dim(training)
dim(validating)
dim(testing)

# ggplot(tab, aes(F2, F1, color = Vowel)) +
#   geom_point() +
#   scale_x_reverse(position = "top") +
#   scale_y_reverse(position = "right")


fitControl <- trainControl(method = "repeatedcv", number = 3, repeats = 2, verboseIter = TRUE) ## 3-fold CV repeated two times, zapnutí detailních výpisů

model <- train(Vowel ~ ., data = training, method = "rf", trControl = fitControl)


ggplot(model)
ggplot(model, metric = "Kappa")
model
model$finalModel  # počet stromů a počet použitých proměnných
results <- resamples(list(RF1 = model, RF2 = model))  # Takto jdou pak srovnávat různé modely. Ale nejde do toho dát jen jeden, proto tam 2x dávám ten samý :-)
bwplot(results)
dotplot(results)
summary(results)

# vyhodnotit přesnost na validačních datech
predictions <- predict(model, newdata=validating)
confusionMatrix(predictions, factor(validating$Vowel))

# vyhodnotit přesnost na testovacích datech
predictions <- predict(model, newdata=testing)
confusionMatrix(predictions, factor(testing$Vowel))

