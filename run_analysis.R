##download file to directory of your choosing
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="E:/Coursera/GettingData/CourseProject/Dataset.zip")
## unzip file
unzip(zipfile="E:/Coursera/GettingData/CourseProject/Dataset.zip", exdir = "Dataset")
## check file list
path_rf <- file.path("./Dataset" , "UCI HAR Dataset")
files <-list.files(path_rf, recursive = TRUE)
files
## read x test and train txt files using read.table
xTest <- read.table(file.path(path_rf, "test" , "X_test.txt"), header = FALSE)
xTrain <- read.table(file.path(path_rf, "train" , "X_train.txt"), header = FALSE)
## merge train and test files into one dataset using row bind
mergedata <- rbind(xTest, xTrain)
## read features txt file using read.table to add as column names to mergedata
labelName <- read.table(file.path(path_rf, "features.txt"), header = FALSE)[[2]]
## add as column names to mergedata
colnames(mergedata) <- labelName
## extract out all columns with mean or std
mergedata <- mergedata[, grep("mean|std", labelName)]
## make labels more readable using gsub
newlabel = names(mergedata)
## change mean() to Mean
newlabel <- gsub("?mean[(][)])?", "Mean", newlabel) 
## change std() to Std
newlabel <- gsub("?std[(][)]?", "Std", newlabel) 
## change t to 'time'
newlabel <- gsub("^t", "time", newlabel)
## change f to freq
newlabel <- gsub("^f", "freq", newlabel)
#### change meanFreq() to MeanFreq
newlabel <- gsub("?meanFreq[(][)]?", "MeanFreq", newlabel)
## remove -
newlabel <- gsub("?-?", "", newlabel)
## change BodyBody to Body
newlabel <- gsub("?BodyBody?", "Body", newlabel)
names(mergedata) <- newlabel
## read activity data and merge
yTest <- read.table(file.path(path_rf, "test" , "y_test.txt"), header = FALSE)
yTrain <- read.table(file.path(path_rf, "train" , "y_train.txt"), header = FALSE)
activity <- rbind(yTest, yTrain)
## add column
colnames(activity)[1] <- "ID"
## add activity labels
actlab <- read.table(file.path(path_rf, "activity_labels.txt"), header = FALSE)
colnames(actlab) <- c("ID", "activity")
## join together using plyr
library(plyr)
actjoin <- join(activity, actlab, by="ID")
## add to mergedata using column bind
mergedata <- cbind(activity=actjoin[, "activity"], mergedata)
## read subject data and merge
subTest <- read.table(file.path(path_rf, "test" , "subject_test.txt"), header = FALSE)
subTrain <- read.table(file.path(path_rf, "train", "subject_train.txt"), header = FALSE)
subject <- rbind(subTest, subTrain)
colnames(subject) <- "SubID"
## add to mergedata using column bind
mergedata <- cbind(subject, mergedata)
## create a new data set that has average of each variable for each activity and subject
## install dplyr
install.packages("dplyr")
library(dplyr)
## use summarize function to summarize dataset by SubID and Activity
tidy <- (mergedata%>%group_by(SubID, activity)%>%summarise_each(funs( mean)))
## use write.table to write out tidy dataset in txt file
write.table(tidy, "./tidy.txt", sep = " ", row.names = FALSE)
