if (!require("data.table")) {
  install.packages("data.table")
}

if (!require("reshape2")) {
  install.packages("reshape2")
}

if (!require("plyr")) {
  install.packages("plyr")
}

require("data.table")
require("reshape2")
require("plyr")

download_datasets = function() {
  setwd("C:\\Users\\micah.gaither\\Google Drive\\Coursera\\GetCleanData")
  if (!file.exists("data")) {
    message("Creating data directory")
    dir.create("data")
  }
  if (!file.exists("data\\UCI HAR Dataset")) {
    fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    zipfile="data\\UCI_HAR_data.zip"
    message("Downloading data")
    download.file(fileURL, destfile=zipfile, method="curl")
    unzip(zipfile, exdir="data")
  }
}

# 1. Merges the training and the test sets to create one data set
  merge_datasets = function() {
  x_train <- read.table("data\\UCI HAR Dataset\\train\\X_train.txt")
  y_train <- read.table("data\\UCI HAR Dataset\\train\\y_train.txt")
  subject_train <- read.table("data\\UCI HAR Dataset\\train\\subject_train.txt")
  x_test <- read.table("data\\UCI HAR Dataset\\test\\X_test.txt")
  y_test <- read.table("data\\UCI HAR Dataset\\test\\y_test.txt")
  subject_test <- read.table("data\\UCI HAR Dataset\\test\\subject_test.txt")
  x_merged <- rbind(x_train, x_test)
  y_merged <- rbind(y_train, y_test)
  subject_merged <- rbind(subject_train, subject_test)
  list(x=x_merged, y=y_merged, subject=subject_merged)
}

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
extract_mean_stddev = function(df) {
  # Given the dataset (x values), extract only the measurements on the mean
  # and standard deviation for each measurement.
  # Read the feature list file
  features <- read.table("data/UCI HAR Dataset/features.txt")
  # Find the mean and std columns
  mean.col <- sapply(features[,2], function(x) grepl("mean()", x, fixed=T))
  std.col <- sapply(features[,2], function(x) grepl("std()", x, fixed=T))
  # Extract them from the data
  edf <- df[, (mean.col | std.col)]
  colnames(edf) <- features[(mean.col | std.col), 2]
  edf
}

# 3. Uses descriptive activity names to name the activities in the data set
activity_names = function(df) {
  colnames(df) <- "activity"
  df$activity[df$activity == 1] = "WALKING"
  df$activity[df$activity == 2] = "WALKING_UPSTAIRS"
  df$activity[df$activity == 3] = "WALKING_DOWNSTAIRS"
  df$activity[df$activity == 4] = "SITTING"
  df$activity[df$activity == 5] = "STANDING"
  df$activity[df$activity == 6] = "LAYING"
  df
}

cbind_data <- function(x, y, subjects) {
  # Combine mean-std values (x), activities (y) and subjects into one data
  # frame.
  cbind(x, y, subjects)
}

tidy_dataset = function(df) {
  # Given X values, y values and subjects, create an independent tidy dataset
  # with the average of each variable for each activity and each subject.
  tidy <- ddply(df, .(subject, activity), function(x) colMeans(x[,1:60]))
  tidy
}


clean_data = function() {
  download_datasets()
  datasets_merged <- merge_datasets()
  cx <- extract_mean_stddev(datasets_merged$x)
  cy <- activity_names(datasets_merged$y)
  colnames(datasets_merged$subject) <- c("subject")
  combined <- cbind_data(cx, cy, datasets_merged$subject)
  tidy <- tidy_dataset(combined)
  write.table(tidy, "UCI_HAR_tidydata.txt", row.name=FALSE)
}

