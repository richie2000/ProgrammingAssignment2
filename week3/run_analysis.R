####################
## run_analysis.R ##
####################
#install.packages("dplyr")
library(dplyr)


### Download file if it doesn't already exist in /zip directory
if(!file.exists("./zip")) {
    dir.create("./zip")
    fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(fileUrl, destfile="./zip/Dataset.zip", method="curl")
}

### Unzip data into /data directory
if(!file.exists("./data")) {
    dir.create("./data")
    unzip("./zip/Dataset.zip", exdir = "./data")
}

### Load datasets into dataframes
activityList  <- read.csv("./data/UCI\ HAR\ Dataset/activity_labels.txt", sep="", header=FALSE)
featureList   <- read.csv("./data/UCI\ HAR\ Dataset/features.txt"       , sep="", header=FALSE)
# Training Data
trainFeatures <- read.csv("./data/UCI\ HAR\ Dataset/train/X_train.txt"      , sep="", header=FALSE)
trainActivity <- read.csv("./data/UCI\ HAR\ Dataset/train/y_train.txt"      , sep="", header=FALSE)
trainSubjects <- read.csv("./data/UCI\ HAR\ Dataset/train/subject_train.txt", sep="", header=FALSE)
# Test Data
testFeatures <- read.csv("./data/UCI\ HAR\ Dataset/test/X_test.txt"      , sep="", header=FALSE)
testActivity <- read.csv("./data/UCI\ HAR\ Dataset/test/y_test.txt"      , sep="", header=FALSE)
testSubjects <- read.csv("./data/UCI\ HAR\ Dataset/test/subject_test.txt", sep="", header=FALSE)


# Step 1: Merges the training and the test sets to create one data set.
allFeatures <- rbind(trainFeatures, testFeatures)
allActivity <- rbind(trainActivity, testActivity)
allSubjects <- rbind(trainSubjects, testSubjects)


# Step 2: Uses descriptive activity names to name the activities in the data set
colnames(allFeatures) <- t(featureList[2])
colnames(allActivity) <- "Activity"
colnames(allSubjects) <- "Subject"


# Step 3: Extracts only the measurements on the mean and standard deviation for each measurement.
colsMeanStd <- allFeatures[, grepl(".*Mean.*|.*Std.*", colnames(allFeatures), ignore.case=TRUE)]
allData <- cbind(allSubjects, allActivity, colsMeanStd)


# Step 4: Appropriately labels the data set with descriptive variable names. 
names(allData) <- sub("Acc"     , "Accelerometer" , names(allData))
names(allData) <- sub("BodyBody", "Body"          , names(allData))
names(allData) <- sub("Gyro"    , "Gyroscope"     , names(allData))
names(allData) <- sub("Mag"     , "Magnitude"     , names(allData))
names(allData) <- sub("^t"      , "Time"          , names(allData))
names(allData) <- sub("^f"      , "Frequency"     , names(allData))


# Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidyDataSet <- aggregate(. ~ Subject + Activity, allData, mean)
write.table(tidyDataSet, file="tidyDataSet.txt", row.name=FALSE)
