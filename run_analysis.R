## GETTING AND CLEANING DATA: Course project ## 
## Juan Jose Garces Iniesta

## Script to perform the project operations specified in the course project 
## instructions :
## https://class.coursera.org/getdata-016/human_grading/view/courses/973758/assessments/3/submissions

## This script needs that the folder "UCI HAR Dataset" with all the files required is 
## in the same folder that the script.

# Loading libraries required if are not installed:
if("plyr" %in% rownames(installed.packages()) == FALSE) {install.packages("plyr")}
library(plyr)
if("dplyr" %in% rownames(installed.packages()) == FALSE) {install.packages("dplyr")}
library(dplyr)
if("reshape" %in% rownames(installed.packages()) == FALSE) {install.packages("reshape")}
library(reshape)

## R script called run_analysis.R that does the following: 

## 1. Merges the training and the test sets to create one data set.
# Reading data into R :
train          <- read.table("./UCI HAR Dataset/train/X_train.txt")
train_labels   <- read.table("./UCI HAR Dataset/train/Y_train.txt")
train_subjects <- read.table("./UCI HAR Dataset/train/subject_train.txt")
test           <- read.table("./UCI HAR Dataset/test/X_test.txt")
test_labels    <- read.table("./UCI HAR Dataset/test/Y_test.txt")
test_subjects  <- read.table("./UCI HAR Dataset/test/subject_test.txt")
features <- read.table("./UCI HAR Dataset/features.txt")
activitys <- read.table("./UCI HAR Dataset/activity_labels.txt")


# Joining data (train+test):
data     <- rbind(train, test)                    # Table 10299 x 561 (data)
labels   <- rbind(train_labels, test_labels)      # Table 10299 x 1   (activity)
subjects <- rbind(train_subjects, test_subjects)  # Table 10299 x 1   (subjects)
total    <- cbind(data, labels, subjects)         # Table 10229 x 563 (All in a table)

## 2. Extracts only the measurements on the mean and standard deviation 
#    for each measurement.
# Because I don't know the exact significance of each one of the original data set variables, 
# I will use all of them with characters "mean()" or "std()" in the name
x <- as.character(features$V2) # Transformation to character vector needed to look for
m <- grep("mean()", x)     # Indexes to mean() variables
s <- grep("std()", x)      # Indexes to std() variables
ms <- c(m,s,562,563)     # Join the indexes mean()+std()+labels+subjects
ms_lite <- c(m,s)        # (Indexes used later)

# Reduction of the table to only mean()+std() measuraments + labels + subjects:
total <- total[ms]       # Table 10299 x 81

## 3. Uses descriptive activity names to name the activities in the data set
# (total$V1.1 is the column of activity). 

total$V1.1<-mapvalues(total$V1.1, c(1,2,3,4,5,6),
c("LAYING","SITTING","STANDING","WALKING","WALKING_DOWNSTAIRS","WALKING_UPSTAIRS"))

## 4. Appropriately labels the data set with descriptive variable names. 
## Names of variables are taken from the "features.txt" files 
names <- c(x[ms_lite], "ACTIVITY", "SUBJECT")
colnames(total) <- names

## 5. From the data set in step 4, creates a second, independent tidy data set 
##    with the average of each variable for each activity and each subject 
##    (tidy_dataMeans)

# Function melt() allows to specify index(id) variables (ACTIVITY and SUBJECT) and reshape
# the data into a large dataframe with only 4 variables/columns:
# ACTIVITY, SUBJECT, variable, value
md <- melt(total, id=c("ACTIVITY", "SUBJECT")) 

# Cast function allows grouping by id variables and apply a funtion to this groups:
tidy_dataMeans<-cast(md, ACTIVITY+SUBJECT~variable, mean)

# Save the data frame with the results in a .txt file 
# (specified in the Project instruccions )
write.table(tidy_dataMeans, file="dataMeans.txt", row.names=FALSE)

# Remove all of the objects created to the workspace:
rm(list=ls())

## EOF
