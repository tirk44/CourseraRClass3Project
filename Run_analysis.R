
## Step 1: Create a merged, tidy data set with all test and train records

setwd("C:/Users/Tim/Documents/R programming/03 Data Course/project/UCI HAR Dataset") ##this is my local directory
install.packages("data.table")
library("data.table")

## From root directory, creates a vector of the column names for the future table
file1 <- "./features.txt"
labels <- read.table(file1, row.names=1)
labels <- t(labels)  ##transposes the column with the row

## imports and merges training data
setwd("C:/Users/Tim/Documents/R programming/03 Data Course/project/UCI HAR Dataset")
setwd("./train")
file1 <- "./y_train.txt" ## ytrain.txt contains the 6 different types of activities
ytrain <- read.table(file1)
colnames(ytrain) <- c("activitytype") ##applies correct column name to ydata
file1 <- "./X_train.txt" ## xtrain.txt contains the 561 measures of data
xtrain <- read.table(file1)
file1 <- "./subject_train.txt" ##subject_train.txt applies the 30 subjects to the rows in x_train & y_train
strain <- read.table(file1)
colnames(strain) <- c("subject") ##applies correct title as subject
ytrain <- data.table(ytrain) ##converts data frames to data tables for easier merging/rpocessing
xtrain <- data.table(xtrain)
strain <- data.table(strain)
colnames(xtrain) <- labels ##applies the correct column names on the 561 variables'
mtrain<-cbind(strain,ytrain,xtrain)  ## merge tables together to complete full training set

## imports and merges testing data
setwd("C:/Users/Tim/Documents/R programming/03 Data Course/project/UCI HAR Dataset") ##sets local main directory
setwd("./test") 
file1 <- "./y_test.txt" ## ytrain.txt contains the 6 different types of activities
ytest <- read.table(file1)
colnames(ytest) <- c("activitytype") ##applies correct column name to ydata
file1 <- "./X_test.txt" ## xtrain.txt contains the 561 measures of data
xtest <- read.table(file1)
file1 <- "./subject_test.txt" ##subject_train.txt applies the 30 subjects to the rows in x_train & y_train
stest <- read.table(file1)
colnames(stest) <- c("subject") ##applies correct title as subject
colnames(xtest) <- labels ##applies the correct column names on the 561 variables'
ytest <- data.table(ytest) ##converts data frames to data tables for easier merging/rpocessing
xtest <- data.table(xtest)
stest <- data.table(stest)
mtest<-cbind(stest,ytest,xtest)  ## merge tables together to complete full TESTING set
## write.table(mergedset, "tidy_V1.txt", sep = ,) ##pasted file in testing of script, commented out during actual running

mergedset <- rbind(mtrain,mtest)
## write(mergedset, "./output-tidy1.csv")

## Step 2: extract only the measurements on the mean and standard deviation
## per the previous style guide, the terms used are "mean" and "std"
## the next function looks for all titles with those names, plus columns 1 & 2 
## which include the test subject and activity type

  cols <- sort(c(1,2,grep("mean",names(mtrain), ignore.case = TRUE),
          grep("std",names(mtrain), ignore.case = TRUE)))
  merged2 <- mergedset[,cols, with=FALSE]

## Step 3: replaces the numbers with the activity names in the set
merged2$activitytype <- gsub(1,"WALKING",merged2$activitytype)
merged2$activitytype <- gsub(2,"WALKING_UPSTAIRS",merged2$activitytype)
merged2$activitytype <- gsub(3,"WALKING_DOWNSTAIRS",merged2$activitytype)
merged2$activitytype <- gsub(4,"SITTING",merged2$activitytype)
merged2$activitytype <- gsub(5,"STANDING",merged2$activitytype)
merged2$activitytype <- gsub(6,"LAYING",merged2$activitytype)

## Step 4: rename columns consistently: Make t into time, std into standarddeviation, 
## acc into acceleration, remove all parenthesis, and make all letters lowercase 

names(merged2) <- tolower(names(merged2))
names(merged2) <- sub("^t","time",names(merged2), ignore.case = TRUE)
names(merged2) <- sub("freq","frequency",names(merged2), ignore.case = TRUE)
names(merged2) <- sub("^f","frequency",names(merged2), ignore.case = TRUE)
names(merged2) <- sub("acc","accelerometer",names(merged2), ignore.case = TRUE)
names(merged2) <- sub("gyro","gyroscope",names(merged2), ignore.case = TRUE)
names(merged2) <- sub("mag","magnitude",names(merged2), ignore.case = TRUE)
names(merged2) <- sub("std","standarddeviation",names(merged2), ignore.case = TRUE)
names(merged2) <- sub("tbody","timebody",names(merged2), ignore.case = TRUE)
names(merged2) <- sub("()","",names(merged2), ignore.case = TRUE)
names(merged2)

## Step 5: aggregate by activity type and subject creating "wide" version
setwd("C:/Users/Tim/Documents/R programming/03 Data Course/project/UCI HAR Dataset")
tidy2 <- aggregate(merged2, by = list(merged2$subject, merged2$activitytype), FUN = "mean")
tidy2 <- tidy2[,c(1:2,5:90)] ## fix columns
colnames(tidy2)[1:2]<-c("subject","activitytype") ## fix column names
write.table(tidy2, "./tidy2.txt", row.names=FALSE) 
