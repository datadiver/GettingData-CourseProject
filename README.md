## GETTING AND CLEANING DATA: Course project ## 
## Juan Jose Garces Iniesta

"run_analysis.R": script to perform the project operations specified in the course project instructions :
https://class.coursera.org/getdata-016/human_grading/view/courses/973758/assessments/3/submissions


Details from the origin of the data and purpose:
===============================================

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.


The dataset includes and need the following files:
===================================================
-  Script 'run_analysis.R' wich obtain a tidy dataset named 'dataMeans.txt' from the data given.

- 'README.txt': Information about the script, files and working details.

- 'Codebook.txt': Shows information about the variables used in the script.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

- 'test/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.
- The folder "UCI HAR Dataset" with all the files required must be in the same folder that the script.


R script description and purpose: 
=================================
From the data given (in a raw/preprocessed way), the script generates an independent tidy data set (named "dataMeans.txt") with the average of each variable for each activity and each subject.
Following the Project specifications, this only is made for mean and standard desviation measuraments.


Need "plyr","dplyr" and "reshape" packages: Load libraries if are not installed.

1. Merges the training and the test sets to create one data set: 

- Reading data into R with read.table()
- Joining data (train + test):
	data     <- Table 10299 x 561 (data)
	labels   <- Table 10299 x 1   (activity)
	subjects <- Table 10299 x 1   (subjects)
	total    <- Table 10229 x 563 (All in a table)

2. Extracts only the measurements on the mean and standard deviation for each measurement.
 
Because I don't know the exact significance of each one of the original data set variables, I will use all of them with characters "mean()" or "std()" in the name
- Function grep() for search mean() and std() in column names
- Reduction of the table to only mean()+std() measuraments + labels + subjects: Table 10299 x 81


3. Uses descriptive activity names to name the activities in the data set
- Function mapvalues() to assign new values("LAYING", "SITTING", etc.) to old ones (1,2,etc.)

4. Appropriately labels the data set with descriptive variable names: Names of variables are taken from the "features.txt" files and assigned with colnames()
- Names of variables are taken from the "features.txt" files 
- Function colnames()


5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject:
   "tidy_dataMeans"

- Function melt() allows to specify index(id) variables (ACTIVITY and SUBJECT) and reshape the data into a large dataframe with only 4 variables/columns:
  ACTIVITY, SUBJECT, variable and value.
- For each ACTIVITY and SUBJECT, calculates the mean for each measurement: cast() function allows grouping by id variables and apply a funtion to this groups.
- Save the data frame with write.table() with the name "dataMeans.txt"



DETAILS FROM THE ORIGINAL DATA AND AUTHORS :
============================================
 
Human Activity Recognition Using Smartphones Dataset
Version 1.0
==================================================================
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
==================================================================



## END OF README.TXT