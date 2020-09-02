library(rlang)
library(dplyr)
library(data.table)

runscript <- function(testdf, traindf){
    ##merge datasets then name columns with exaustive names
    ##and then extract only mean and std measurements
    features <- read.table("./UCI\ HAR\ Dataset/features.txt")
    colnames(testdf) <- features$V2
    colnames(traindf) <- features$V2
    fulltable <- rbind(testdf, traindf)
    fulltable <- select(fulltable, grep("-mean\\(\\)|-std\\(\\)", colnames(fulltable)))
    
    ##add activity column
    labels <- read.table("./UCI\ HAR\ Dataset/activity_labels.txt")
    ytest <- read.table("./UCI\ HAR\ Dataset/test/y_test.txt")
    ytrain <- read.table("./UCI\ HAR\ Dataset/train/y_train.txt")
    yfinal <- rbind(ytest, ytrain)
    yfinal <- inner_join(yfinal, labels, by="V1")
    activity <- yfinal$V2
    fulltable <- cbind(fulltable, activity)
    rm(labels, yfinal, activity, ytest, ytrain)
    
    ##add subject
    testsubject <- read.table("./UCI\ HAR\ Dataset/test/subject_test.txt")
    trainsubject <- read.table("./UCI\ HAR\ Dataset/train/subject_train.txt")
    fullsubject <- rbind(testsubject, trainsubject)
    names(fullsubject)[names(fullsubject)=="V1"] <- "subject"
    fulltable <- cbind(fulltable, fullsubject)
    rm(fullsubject, testsubject, trainsubject)
    
    ##creating tidy dataset with the mean of all variables, grouped by subject and activity
    tidydata <- fulltable %>% group_by(subject, activity) %>% arrange(subject, activity) %>% summarize(across(everything(), mean))
    write.table(tidydata, "./tidy.txt", row.names = F)
    tidydata
}



run <- function(){
    testdf <- read.table("./UCI\ HAR\ Dataset/test/X_test.txt")
    traindf <- read.table("./UCI\ HAR\ Dataset/train/X_train.txt")
    runscript(testdf, traindf)
}
