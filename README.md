This is the course project for Getting and Cleaning Data course on Coursera. Code is written in R in file. Source file is run_analysis.R. This R script does the following things:

Loads all the files into into variables.
  - Loading Test data into variables
  - Loading Train data into variables
  - Load Activity Labels into variables
  - Load Features into variables
  
Then follows the assignment steps:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Final output file is tidydata.txt

This repo contains:

run_analysis.R, an R script, which downloads the source data archive and creates the final dataset.

CodeBook.md, listing and description of variables in data.

tidydata.txt, the final data, which can be read into r with the code below: read.table("tidydata.txt", sep="\t", header = TRUE)