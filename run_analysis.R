#R script called run_analysis.R  does the following.

#1. Merges the training and the test sets to create one data set.
#2. Extracts only the measurements on the mean and standard deviation for each measurement.
#3. Uses descriptive activity names to name the activityLabels in the data set
#4. Appropriately labels the data set with descriptive variable names.
#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

library(dplyr)
pathToData<-"~/Data Science Learning/Getting Data Cleaned/Week 4/Project"

############## LOADING DATA INTO VARIABLES ################

# Loading Test data into variables
subjectsTest <- read.table(file.path(pathToData, "test", "subject_test.txt"))
xTest <- read.table(file.path(pathToData, "test", "X_test.txt"))
yTest <- read.table(file.path(pathToData, "test", "y_test.txt"))

# Loading Train data into variables
subjectTrain <- read.table(file.path(pathToData, "train", "subject_train.txt"))
xTrain <- read.table(file.path(pathToData, "train", "X_train.txt"))
yTrain <- read.table(file.path(pathToData, "train", "y_train.txt"))

# Load Activity Labels into variables
activityLabels <- read.table(file.path(pathToData, "activity_labels.txt"))

# Load Features into variables
features <- read.table(file.path(pathToData, "features.txt"), as.is = TRUE)

## Columns Names
colnames(activityLabels) <- c("activityId", "activityLabel")

#################### 1. MERGE TRAINING AND TEST DATA SETS #################

# Merge train and test Data sets
mergeTrain<-cbind(subjectTrain, xTrain, yTrain)
mergeTest<-cbind(subjectsTest, xTest, yTest)

humanExperiment <- rbind( mergeTrain,  mergeTest)

# assign column names
colnames(humanExperiment) <- c("subject", features[, 2], "activity")


########### 2. Extract only the measurements on the mean and standard deviation for each measurement ########################

# Keep only subject, activity, mean and standard deviation columns
humanExperiment <- humanExperiment[, grepl("subject|activity|mean|std", colnames(humanExperiment))]


#############3. Use descriptive activity names to name the activityLabels in the data set #########

levels = activityLabels[, 1]
labels = activityLabels[, 2]

humanExperiment$activity <- factor(humanExperiment$activity, 
                                 levels, labels )


##############4.  Appropriately labels the data set with descriptive variable names #############
# get column names
humanExperimentCols <- colnames(humanExperiment)

# remove special characters
humanExperimentCols <- gsub("[\\(\\)-]", "", humanExperimentCols)

# expand abbreviations and clean up names
humanExperimentCols <- gsub("^f", "frequency", humanExperimentCols)
humanExperimentCols <- gsub("^t", "time", humanExperimentCols)
humanExperimentCols <- gsub("Acc", "Accelerometer", humanExperimentCols)
humanExperimentCols <- gsub("Gyro", "Gyroscope", humanExperimentCols)
humanExperimentCols <- gsub("Mag", "Magnitude", humanExperimentCols)
humanExperimentCols <- gsub("std", "StandardDeviation", humanExperimentCols)
humanExperimentCols <- gsub("BodyBody", "Body", humanExperimentCols)

colnames(humanExperiment) <- humanExperimentCols


############### 5 - Create a second, independent tidy set with the average of each variable for each activity and each subject
humanExperimentMeans<-aggregate(. ~subject + activity, humanExperiment, mean)
humanExperimentMeans<-humanExperimentMeans[order(humanExperimentMeans$subject,humanExperimentMeans$activity),]
write.table(humanExperimentMeans, file = "tidydata.txt",row.name=FALSE,quote = FALSE, sep = '\t')

