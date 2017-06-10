# Introduction

The script is named `run_analysis.R`
'run_analysis.R' performs the following:
- Downloads the data from
  [Coursera Project Data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) 
- Merges the training and the test sets to create one data set
- Extracts only the measurements on the mean and standard deviation for each measurement
- Uses descriptive activity names to name the activities in the data set
- Appropriately labels the data set with descriptive variable names
- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
  
# run_analysis.R
The script is sectioned such that each area performs one of the steps above. To run the entire procedure, call the 'clean_data' function.

# The original data set

The original data set is split into training and test sets where each partition is also split into three files that contain
- measurements from the accelerometer and gyroscope
- activity label
- identifier of the subject

# Getting and cleaning data

If the data is not already available in the `data` directory, it is downloaded
from UCI repository.

The first step is to merge the training and test sets. 

After the merge operation, mean and standard deviation features are extracted
for further processing. 

Next, the activity labels are replaced with descriptive activity names, defined
in `activity_labels.txt` in the original data folder.

The final step creates a tidy data set with the average of each variable for
each activity and each subject. The tidy data set is exported to `UCI_HAR_tidydata.txt` where the first row is the
header containing the names for each column.
