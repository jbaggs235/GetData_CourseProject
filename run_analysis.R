
## Assume starting in the UCI HAR Dataset directory
## Change workdirectory to train
setwd("train")

## Read in the train files
subject_train <- read.table("subject_train.txt")
x_train <- read.table("X_train.txt")
y_train <- read.table("y_train.txt")

## Move back to the original working directory
setwd("..")

## Read the test files
setwd("test")
subject_test <- read.table("subject_test.txt")
x_test <- read.table("X_test.txt")
y_test <- read.table("y_test.txt")

## Go to original working directory and read in variable names and activity descriptions
setwd("..")
features <- read.table("features.txt")
activity_labels <- read.table("activity_labels.txt")

## Set the variable names onto the x_train and x_test data files
col_names <- features[,2]
colnames(x_train) <- col_names
colnames(x_test) <- col_names
colnames(subject_train) <- c("Subject_ID")
colnames(subject_test) <- c("Subject_ID")
colnames(y_train) <- c("Activity_Code")
colnames(y_test) <- c("Activity_Code")
colnames(activity_labels) <- c("Activity_Code","Activity")

## Select mean and std values only
mean_var_list <- features[grep("mean()",features$V2,fixed=TRUE),]
std_var_list <- features[grep("std()",features$V2,fixed=TRUE),]
mean_std <- rbind(mean_var_list,std_var_list)
x_train2 <- x_train[,mean_std[,1]]
x_test2 <- x_test[,mean_std[,1]]

## Merge subject, x, and y dataset
train <- cbind(subject_train,y_train,x_train2)
test <- cbind(subject_test,y_test,x_test2)

## Merge test and train vertically
all_data <- rbind(train,test)

## Merge activity descriptions onto dataset
all_data2 <- merge(all_data,activity_labels,by.x="Activity_Code",by.y="Activity_Code",all=TRUE)

## create a tidy data with the mean of each variable for each subject and activity
library(reshape)
all_data3 <- melt(all_data2, id=c("Subject_ID","Activity_Code","Activity"))
tidy1 <- cast(all_data3,Subject_ID+Activity_Code+Activity~variable,mean)
# tidy1 is the wide version of the tidy dataset with 180 obs and 68 columns
tidy2 <- melt(tidy1,id=c("Subject_ID","Activity_Code","Activity"))
#tidy 2 is the long version of the tidy dataset with 4 columns and 11,800 obs

colnames(tidy2)[colnames(tidy2)=="value"] <- "Average"
colnames(tidy2)[colnames(tidy2)=="variable"] <- "Variable"

## Delete Activity_Code variable
tidy2$Activity_Code <- NULL

## Write out the datafile
write.table(tidy2,file="CourseProject_Tidy.txt",row.names=FALSE)

## eof
