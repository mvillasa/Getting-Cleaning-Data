# Getting-Cleaning-Data
Repo Contains the material for the course proyect in Getting and Cleaning Data in Coursera. November 2015.

This is to collect two tidy data sets from data collected from accelerometers from the Samsung Galaxy S smartphone.  There is a total of 10299 observations that are subdivided into the test data (2947 observations) set and the train data set (7352 observations). The data consists of 561 measurements for both test and train sub-data sets (x_test.txt and x_train.txt respectively), the 30 subjects perform 6 diffent types of activities that are detailed in activity_label.txt.  In y_test.txt and y_train.txt the type of activity performed by each subject is recorded for both the test and train sub-data sets respectively. In subject_test.txt the subject's ID is recorded. 

The complete data set can be download from the following link: 

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Once downloaded the raw data it must be decompressed into a directory. 
Set the working directory in R to be that where the directories test and train are created once the data set is decompressed. #IMPORTANT: 
When running the R script keep in mind that you must the working directory before reading in the data sets.  

There is only one script for processing the data (run_analysis.R), the script clearly states the beginning of a part or section of the script in perfoming the steps for obtaining the tidy data which are outlined as follows:

#Part 1:
merges training set and test sets to create one data set.  The data set it constructed so that the training data are in the first rows followed by the test data.  A new column is added to indicate the type of data (train or test).

#Part 2: 
extract only the measurements on the mean and standard deviation for each measurement.  The feature_info.txt provides the names for the 561 columns of the data.  Using that unformation a total of 33 variables were identified as belonging to the mean of a measurement and 33 for the standrd deviation.  Using those especific columns, a new data set was constructed with 66 columns + subject + activity + type of data giving a total of 69 columns in the data set.

#Part 3: 
Uses descriptive activity names to name the activities in the data set.  The names Given in activity_labels.txt were used to label appropriately. Also the type of data was set to either "train" or "test".

#Part 4:
Appropriately labels the data set with descriptive variable names.  Many of the variable names in the features_inf.txt file were thought of as cumbersome to use, therefore a number of acronyms were used and patched together to form new names.  

	t 	-> t
	f 	-> f
	body 	-> B
	Acc 	-> A
	Jerk 	-> J
	Gravity -> Gr
	Gyro 	-> Gy
	Mag 	-> M
	X 	-> X
	Y 	-> Y
	Z 	-> Z
	mean 	-> m
	std 	-> std

For example: tbodyGyroJerkX-mean is labelled as tBGyJ_x_m

#Part5: 
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.  This new data set consists of 180 rows (30 subjects times 6 activities) and the 69 columns from Parts 2-4.
#Note: 
For part 5 to function properly the dplyr package must be loaded into R.
