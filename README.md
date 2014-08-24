## Getting and Cleaning Data Course Project

### Overview
This repository contains my solution for the course project from Coursera's and Johns Hopkins University's course titled Getting and Cleaning Data.  

The purpose of the project is to test our ability to collect, work with, and clean a data set.  We are to demonstrate that we can prepare tidy data that can bse used for later analysis.  The data set is from from the [University of California, Irvine's Machine Learning Repository]{http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#}.  The actual data used for this project can be [downloaded from here]{https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip}.

You should find the following files in this repository:

* README.md - The current file you are viewing
* CodeBook.md - This is the code book for the data set generated for this project
* run_analysis.R - This is the script that generates the tidy data set for this project

### run_analysis.R Summary
The run_analysis.R script will complete all of the necessary steps to generate the tidy data set required for this project:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

### Generating the Tidy Data Set
To use run_analysis.R you must make sure that you have downloaded the data set, extracted it from the zip file, and moved the resulting folder into the same directory that contains the script.  run_analysis.R will check to make sure that the folder UCI HAR Dataset exists in the same directory as the script before executing.  Once it finds it, it will generate tidyData.txt, a tab separated file that contains the tidy data set along with headers labels for each of the columns.

### Additional Information
There is greater detail about the actual data set contained in CodeBook.md.  Make sure to read it to get a greater understanding about the resulting tidyData.txt file that is the output from run_analysis.R.