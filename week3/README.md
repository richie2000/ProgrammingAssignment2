# README.md

## Download file if it doesn't already exist in /zip directory
Check if /zip directory exists.
Download if it doesn't.

## Unzip data into /data directory
Check if /data directory exists.
Unzip file if it doesn't.

## Load datasets into dataframes
Load data into data frames.
activityList  = "./data/UCI\ HAR\ Dataset/activity_labels.txt"
featureList   = "./data/UCI\ HAR\ Dataset/features.txt"
trainFeatures = "./data/UCI\ HAR\ Dataset/train/X_train.txt"
trainActivity = "./data/UCI\ HAR\ Dataset/train/y_train.txt"
trainSubjects = "./data/UCI\ HAR\ Dataset/train/subject_train.txt"
testFeatures = "./data/UCI\ HAR\ Dataset/test/X_test.txt"
testActivity = "./data/UCI\ HAR\ Dataset/test/y_test.txt"
testSubjects = "./data/UCI\ HAR\ Dataset/test/subject_test.txt"

## Step 1: Merges the training and the test sets to create one data set.
Join the training and test sets into single files using rbind().
allFeatures = trainFeatures + testFeatures
allActivity = trainActivity + testActivity
allSubjects = trainSubjects + testSubjects

## Step 2: Uses descriptive activity names to name the activities in the data set
Add the 2nd column from the featureList to the allFeatures dataframe.
Rename the column in the allActivity dataframe to "Activity"
Rename the column in the allSubject dataframe to "Subject"

## Step 3: Extracts only the measurements on the mean and standard deviation for each measurement.
Get only the columns that contain "Mean" and "Std" from the allFeatures list.
Join this to the Activity and Subject dataframes.

## Step 4: Appropriately labels the data set with descriptive variable names. 
Rename a few of the columns with better descriptions.
e.g. "Acc" to "Accelerometer", "Mag" to "Magnitude" 

## Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Grouping by Subject and Activity, get the mean for all the other columns.
Write the result into a file called "tidyDataSet.txt"
