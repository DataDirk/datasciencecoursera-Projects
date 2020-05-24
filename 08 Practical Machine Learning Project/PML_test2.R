library(dplyr)
library(readr)
library(caret)
library(rpart)
library(rattle)
library(randomForest)

library(parallel)
library(doParallel)



rm(list = ls())


train_url <- "http://d396qusza40orc.cloudfront.net/predmachlearn/pml-training.csv"
quiz_url <- "http://d396qusza40orc.cloudfront.net/predmachlearn/pml-testing.csv"


trainingset <- read_csv(train_url, na=c("#DIV/0!","NA", ""))
quizset <- read_csv(quiz_url, na=c("#DIV/0!","NA", ""))


str(trainingset[c(1:20)])



# drop the first seven columns
train1<- trainingset[-c(1:7)]

# only keep columns which don't contain missing values NA
train2<-select(train1, which(colSums(is.na(train1[, ]))==0))

# encode variable classe as factor
train2$classe<-factor(train2$classe)


nearZeroVar(train2)


set.seed(12345)

inTrain <- createDataPartition(y=train2$classe, p=0.7, list=FALSE)
# create training dataset
train_data <- train2[inTrain,]

# create test dataset
test_data <- train2[-inTrain,]


# create classification tree model from for variable classe in the training dataset
#modFit_PT <- rpart(classe ~ ., data=train_data, method="class")


#fancyRpartPlot(modFit_PT)


#predict_PT <- predict(modFit_PT, test_data, type = "class")
#cm_PT <- confusionMatrix(predict_PT, test_data$classe)
#cm_PT

cluster <- makeCluster(detectCores()- 1)
registerDoParallel(cluster)


#modFit_RF <- train(classe~ .,data=train_data, method="rf")
#modFit_RF <- randomForest(classe ~ ., data=train_data, importance=TRUE)
time_start <- proc.time()

# 10-fold cross validation, takes about 7min to complete with parallel processing
modFit_RF <- train(
  classe ~ ., 
  train_data,
  method = "rf",
  trControl = trainControl(
    method = "cv", 
    number = 10,
    verboseIter = TRUE,
    allowParallel = TRUE
  )
)
time_used <- proc.time() - time_start
print(time_used)

stopCluster(cluster)
registerDoSEQ()

plot(modFit_RF)


predict_RF <- predict(modFit_RF, test_data, )


cm_RF <- confusionMatrix(predict_RF, test_data$classe)
cm_RF


# Using modFit_RF to predict quiz results
quiz_RF <- predict(modFit_RF, quizset)
quiz_RF
