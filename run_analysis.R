################################################################################
#                                                                              #
# Coursera Getting and Cleaning Data Course Project                            #
# Scott Norman                                                                 #
# August 24, 2014                                                              #
#                                                                              #
# run_analysis.R                                                               #
# This script will perform the following steps required in the project         #
# description:                                                                 #
#                                                                              #
# 1. Merges the training and the test sets to create one data set              #
# 2. Extracts only the measurements on the mean and standard eviation for each #
#    measurement                                                               #
# 3. Uses descriptive activity names to name the activities in the data set    #
# 4. Appropriately labels the data set with descriptive activity names         #
# 5. Creates a second, independent tidy data set with the average of each      #
#    variable for each activity and each subject                               #
#                                                                              #
################################################################################

# Clean up the workspace
rm(list=ls())

# Check for existence of the Samsung data in the working directory
if(!file.exists("UCI HAR Dataset")) {
  # May already be in the directory after a previous run, make sure
  setwd('..');
  
  if(!file.exists("UCI HAR Dataset")) {
    stop("'UCI HAR Dataset' folder is not located in working directory.", 
        call. = F);
  } else {
    setwd("UCI HAR Dataset");
  }
} else {
  setwd("UCI HAR Dataset");
}

################################################################################
## Step 1: Merges the training and the test sets to create one data set       ##
################################################################################

# Read all of the data from files the training and test files
features               = read.table('./features.txt');

activityLabels         = read.table('./activity_labels.txt');
names(activityLabels)  = c('activityId', 'activityLabel');

subjectTrain           = read.table('./train/subject_train.txt');
names(subjectTrain)    = "subjectId";

xTrain                 = read.table('./train/x_train.txt');
names(xTrain)          = features[,2];

yTrain                 = read.table('./train/y_train.txt');
names(yTrain)          = "activityId";

subjectTest            = read.table('./test/subject_test.txt');
names(subjectTest)     = "subjectId";

xTest                  = read.table('./test/x_test.txt');
names(xTest)           = features[,2];

yTest                  = read.table('./test/y_test.txt');
names(yTest)           = "activityId";

# Merge yTrain, subjectTrain and xTrain to create training data
trainingData = cbind(yTrain, subjectTrain, xTrain);

# Merge the xTest, yTest and subjectTest data to create test data
testData = cbind(yTest, subjectTest, xTest);

# Combine training and test data to create the final data set
mergedData = rbind(trainingData, testData);

################################################################################
## Step 2: Extracts only the measurements on the mean and standard deviation  ##
## for each measurement.                                                      ##
################################################################################

# This is used to create the filter to build the subset based on column names
columns = colnames(mergedData);

# This will create a logical vector that is True when a column is an Id, std()
# or mean() column.  This defeats columns that end in mean()-X or std()-X
logicalVector = grepl("activity|subject|mean\\(\\)$|std\\(\\)$", columns);

# Use the logicalVector to subset mergedData and keep only the desired columns
mergedData = mergedData[logicalVector];

## Note - Step 3 has been moved to after Step 5 since it makes more logical 
## sense to do it at that point in the script

################################################################################
## Step 4: Appropriately labels the data set with descriptive variable names  ##
################################################################################

# Fix up the column names so they are more descriptive
columns = names(mergedData);
columns = gsub("-std", "StdDev", columns);  # Replace '-std' with 'StdDev'
columns = gsub("-mean", "Mean", columns);   # Replace '-mean' with 'Mean'
columns = gsub("^t","time",columns);        # Expand time for column names
columns = gsub("^f","freq",columns);        # Expand frequency for column names
columns = gsub("[Bb]ody[Bb]ody",            # Get rid of instances of BodyBody
                "Body", columns);
columns = gsub("Mag", "Magnitude",columns); # Expand 'Mag' to 'Magnitude'
columns = gsub("[()-]", "", columns);       # Remove parenthesis and dashes
names(mergedData) = columns;

################################################################################
## Step 5: Creates a second, independent tidy data set with the average of    ##
## each variable for each activity and each subject.                          ##
################################################################################

# Using the aggregate function to calculate means for each variable grouped by
# activity and subject
tidyData = aggregate(mergedData[,names(mergedData) != c('activityId','subjectId')], 
                     by = list(activityId = mergedData$activityId, 
                               subjectId = mergedData$subjectId), mean);

################################################################################
## Step 3: Uses descriptive activity names to name the activities in the data ##
## set                                                                        ##
################################################################################

# Merging the tidyData with activityLabels to include descriptive activity names
tidyData = merge(tidyData, activityLabels, by='activityId', all.x=TRUE);

## Output should be the tidy data set submitted for part 1.
write.table(tidyData, './tidyData.txt', row.names=FALSE, sep='\t');