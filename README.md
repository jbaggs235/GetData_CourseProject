# GetData_CourseProject
Getting and Cleaning Data Course Project, Coursera course getdata-011, creating a tidy dataset, Feb. 2015

Programmer: jbaggs235
Getting and Cleaning Data Course Project
Coursera course: getdata-011
Date: 02/21/2015

Data Source:

The original source of the data was obtained from:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Additional information about the data and study was obtained from the above source.

Citation:
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013.


Github repository link:
https://github.com/jbaggs235/GetData_CourseProject

Instruction List:

Assumptions:
1.	The working directory is set to the “UCI HAR Dataset” directory. And there are two subfolders containing the data named as “train” and “test”. Within “train” are the subject_train.txt, y_train.txt, and x_train.txt files. Within “test” are the subject_test.txt, y_test.txt, and x_test.txt files. Within the “UCI HAR Dataset” directory is the features.txt and activity_labels.txt files.
2.	The “reshape” package is available to be loaded in the script.

Process (see R script run_analysis.R):
1.	The working directory is set to the train subdirectory, and the subject_train.txt, y_train.txt, and x_train.txt files are read into R using the read.table statement.
2.	The working directory is then set to the test subdirectory, and the subject_test.txt, y_test.txt, and x_test.txt files are read into R using the read.table statement.
3.	The working directory is then set again to the “UCI HAR Dataset”, and the features.txt and activity_labels.txt files are read into R using the read.table statement.
4.	Using the information in the features datafile, which contains 561 rows and 2 columns, the column names for the x_train and x_test datafiles are set to the variable names contained in the features datafile by creating a list of names from the features datafile.
5.	Column names for the subject_train and subject_test datafiles are set to “Subject_ID” to provide descriptive variable names.
6.	Column names for the y_train and y_test datafiles are set to “Activity_Code” to provide descriptive variable names.
7.	Column names for the activity_labels datafile are set to “Activity_Code” and “Activity” to provide descriptive variable names. The datafile contains the list of 6 activities and the corresponding code. There are 6 rows and 2 columns.
8.	The subject_train and subject_test datafiles contain the subject ID numbers for each of participants for each activity across multiple measurements. Each has 1 column and there are 7352 and 2947 rows respectively.
9.	The y_train and y_test datafiles contain the activity codes for each of the participants and each activity across multiple measurements. Each file has 1 column and 7352 and 2947 rows respectively.
10.	The x_train and x_test datafiles contain the 561 measurements for each participant and each activity described in the subject_train/test and y_train/test datafiles. Each file has 561 columns and 7352 and 2947 rows respectively.
11.	 We extract only the mean and standard deviation measurements using the pattern matching function grep on the features datafile to match variables with either “mean()” or “std()” in the variable name. We build a list of those variable names from the features datafile. We then select only those columns in the x_train and x_test datafiles. In the end, 66 variable measurements containing mean() or std() were selected.
12.	We then stack the subject_train, y_train, and x_train datafiles side by side or horizontally using the cbind function. This creates an intermediate datafile of 68 columns and 7352 rows, which now contains the Subject_ID, Activity_Code, and 66 measurement variables.
13.	We then stack the subject_test, y_test, and x_test datafiles side by side or horizontally using the cbind function. This creates an intermediate datafile of 68 columns and 2947 rows, which now contains the Subject_ID, Activity_Code, and 66 measurement variables.
14.	We then vertically stack the train and test datafiles using the rbind function creating a datafile of 68 columns and 10299 rows.
15.	We then merge onto that datafile the descriptive activity labels from the activity_labels datafile using the merge function. The activity_code variable is our unique identifier between the two files for the merge. 
16.	This now creates the datafile for step 4, which contains all the data from the train and test datafiles, uses descriptive variable names, extracts only mean and standard deviation measurements, and uses descriptive activity names.
17.	We then load the reshape package.
18.	Using the melt and cast functions with a mean argument, we create a datafile with 180 observations and 69 columns. This is the wide version of the final datafile for output in step 5. Three variables identify the subject_ID, activity_code, and activity. The remaining 66 variables describe the mean for each measurement. 
19.	We use the melt function again to create a long version of the tidy datafile for output. This file contains 4 columns including the Subject_ID, Activity label, the Variable being measured, and the mean value of that variable for that particular participant and activity. The activity code column was removed and the columns were given descriptive variable names. This file contains 4 columns and 11880 rows. If there were 30 participants each doing 6 activities and 66 variables measured, one would expect 30*6*66 = 11880 observations.
20.	The dataset created in the previous step (19) is our output file. This file is then saved to the working directory using the write.table function. The file is named “CourseProject_Tidy.txt”. This was the file submitted for the assignment.


Code Book:

Final Dataset: tidy2
Output file: CourseProject_Tidy.txt

Tidy2 is the final dataset. It is outputted as a txt file. Tidy2 is a tidy dataset since each variable is in a single column, each observation is in a single row, and there is a single table for this data output. Tidy2 is long, instead of being wide, with only 4 variables that describe the mean or average value of each mean or standard deviation measurement variable per each participant and each activity. There are 11880 rows in the datafile, which was expected for 30 participants, conducting 6 activities each, and for 66 extracted measurements (30*6*66=11880).

Variables:

Subject_ID: 
Integer number. Range 1-30. 
ID number of the participants in the trial. There were 30 participants that participated and were separated into the train and test datafiles.

Activity:
Text variable. Only 6 potential values including the following: “WALKING” “STANDING” “LAYING” “SITTING” “WALKING_UPSTAIRS” “WALKING_DOWNSTAIRS”.
Describes the activity being conducted by the participant during the measurement from the wearable device.

Variable:
Text variable. 66 potential values that were mean and standard deviation (std) measurements.
Describes the measurement that was derived from the raw data from the wearable device.

Average:
Numeric variable.
The mean or average value of the measurement variable per each participant and each activity. Variable, participant, and activity are denoted by the “Variable”, “Student_ID” and “Activity” columns in that row.
