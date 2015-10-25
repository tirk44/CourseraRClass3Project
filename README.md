This readme will explain how to complete the Run_analysis.R file to generate the tidy2.txt file, which  the final project in the “Getting and Cleaning Data”.  This file will review the input data, how to run the R file, and the resultant output file.

# INPUT DATA
First, you will need to download the following input files to be downloaded from the following location to your local machine.  
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
Extract the zip file to your location where you’ll be working with the data. The list of necessary input files, and their subdirectory, is below.  (For the purposes of this exercise, you will not need the information in the subfolders named) 
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Lists the class labels with their activity name.  There are 6 activities.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.
- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

# R FILE PROCESSING & TRANSFORMATION
Note: The R file is written from the perspective of my local directory.  You will need to download the input data, and set the working directory in the file for your own PC, to make the script work.
The R file is divided in to 5 broad sections.

## Section 1: Creation of tidy data
The input files identified above are imported, step by step, into R. The column names are applied appropriately.  The data frames imported are turned into data tables for faster, easier processing. 
For the x_test and x_train data, the features.txt data is transposed into the column names.  The y_train/y_test file each will have 1 variable while the x_test/x_train will have 561 variables, one column for each set of data provided.
These will be merged step by step into one large data frame called “mergedset”, of 10,299 observations and 563 variables.
Note: If you would like to output these two files to text files, there are commented out script line 46 to run.
## Section 2: Reduction of Columns to Mean & Standard Deviation Only
The instructions are to remove all the columns that do not contain means and standard deviations.  The next function looks for all titles with those names, plus columns 1 & 2 which contain the key subject and activity information. That reduced data frame, merged2, includes the same 10,299 observations but only 88 variables.  
## Section 3: Substitution of Activity Type Number with Name
This section modifies the data such that the digits 1 through 6 are now presented as the names using the table “activity_labels.txt”.
## Section 4: Cleanup of Column Names
This section is admittedly belabored, but cleans up the column headings provided in features.txt into a very readable format, making all abbreviations full words and removing all uppercase letters.  The function format and dashes have been left in for readability per the author’s choice.
## Section 5:Aggregation and Grouping by Subject and Activity Type
Finally, a tidy data set of 180 records, each of the 6 activities for all 30 subjects, taking the mean of every column in the data set.  The column names are cleaned up before a final extract of the tidy2.txt file to your working directory; the filesize should be 286.5 KB. 

