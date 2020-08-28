library(rlang)
library(tidyverse)
part14 <- function(testdf, traindf){
    activity <- read.table("./UCI\ HAR\ Dataset/activity_labels.txt")
    testlabel <- read.table("./UCI\ HAR\ Dataset/test/y_test.txt")
    testlabel <- merge(testlabel, activity, by.x = "V1", sort=F)
    testlabel <- testlabel$V2
    trainlabel <- read.table("./UCI\ HAR\ Dataset/train/y_train.txt")
    trainlabel <- merge(trainlabel, activity, by.x = "V1", sort=F)
    trainlabel <- trainlabel$V2
    rm(activity)
    features <- read.table("./UCI\ HAR\ Dataset/features.txt")
    testdf <- set_names(testdf, features$V2)
    traindf <- set_names(traindf, features$V2)
    testdf <- cbind(testdf, testlabel)
    traindf <- cbind(traindf, trainlabel)
    rm(features)
    colnames(testdf)[562] <- "activity"
    colnames(traindf)[562] <- "activity"
    subjectrain <- read.table("./UCI\ HAR\ Dataset/subject_train.txt")
    subjectest <- read.table("./UCI\ HAR\ Dataset/subject_test.txt")
    cbind(testdf, subjectest)
    cbind(traindf, subjectrain)
    colnames(testdf)[563] <- "subject"
    colnames(traindf)[563] <- "subject"
    res <- rbind(testdf, traindf)
    res <- select(res, grep("[M|m]ean|std|activity", colnames(res), value=T))
    rm(testlabel)
    rm(trainlabel)
    ##write.csv(res, "./res1.csv")
    res
}

runscript <- function(testdf, traindf){
    data <- part14(testdf, traindf)
    newdata <- aggregate(data, by=list(data$activity, data$type), mean)
    newdata <- newdata[,1:88]
    rm(data)
    write.table(newdata, "./dataset.txt", row.name=F)
    newdata
}

run <- function(){
    testdf <- read.table("./UCI\ HAR\ Dataset/test/X_test.txt")
    traindf <- read.table("./UCI\ HAR\ Dataset/train/X_train.txt")
    runscript(testdf, traindf)
}
