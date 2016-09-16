# Getting and Cleaning Data Course Project

The project files consist of 3 files
      (1) run_analysis.R
      (2) Mikhail_Lara_Project_Output.txt
      (3) Codebook

File (1) is the actual script that was used to combine the test and train datasets and produce File (2).

File (2) which is a tidy dataset where the means of all the acclerometer and gyroscope measurements from the original data are calculated and grouped according to the test subject and the activity being performed.

File (3) is the Codebook for File (2) which describes in detail what each variable in File (2) is and indicates the associated units.

# Data Cleaning Procedure

The data cleaning & combining process performed by File (1) is simple. First, it loads both the test and train data into R in addition to the associated feature and activity data. The subject and activity ID data are column appended to the experimental data to create composite data frames for both the test and train data. The 2 new data frames are then row appended to each other to make a single data frame.

Next, files containing the information to decode the features is used to isolated the mean and standard deviation results in conjunction with the grep command and the 'mean|std' literal. Then follows a series of gsub & sub commands to create a character vector that is used as the column names for the tidy dataset. The names of the activities are determined by matching the activity_ID with the values in 'activity_labels.txt'.

The final step of creating a data set with the means of each variable organized by subject and activity is done using the 'melt' and 'dcast' functions in the reshape2 package.


