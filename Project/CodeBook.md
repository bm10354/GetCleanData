#####SOURCE DATA SET DESCRIPTION

Source data set contains 7352+2947=10299 observations of 561 features for 30 subjects performing 6 types of activities
and consists of 8 space-delmited files:
- train/X_train.txt : train set measurments, 7352 rows x 561 columns
- test/X_test.txt : test set measurments, 2947 rows x  561 columns
- train/y_train.txt : train set activitiy ids, 7352 rows x 1 column, rows correspond to train/X_train.txt rows
- test/y_test.txt : test set activitiy ids, 2947 rows x 1 column, rows correspond to test/X_test.txt rows
- train/subject_train.txt : train set subject ids, 7352 rows x 1 column, rows correspond to train/X_train.txt rows, - subject Id = [1:30]
- test/subject_test.txt : test set subject ids, 2947 rows x 1 column, rows correspond to test/X_test.txt rows, subject Id = [1:30]
- features.txt: features(measurments) ids and names, 561 rows x 2 columns, rows correspond to X_train and X_test columns
activity_labels.txt : activity ids and names, 6 rows x 2 columns, first column values equal to y_train and y_test column values
           
         
#####DATA TRANSFORMATION DESCRIPTION

1.MERGE TRAINING AND TEST SETS TO CREATE ONE DATA SET
- Get observations:  read X_train.txt and X_test.txt. 
- They have the same structure so just append latter to former.

2.EXTRACT ONLY MEAN AND STANDARD DEVIATION FOR EACH MEASUREMENT (FEATURE)
- Get featureId - featureName relation: Read filefeatures.txt.
- Filter featureNames that contain "mean" or "std".
- Use this filter as index to reduce number of columns.
 
3.USE DESCRIPTIVE ACTIVITY NAMES
- Get ActivityId for each observation: Read y_train.txt and x_test.txt, append.
- Get ActivityId - ActivityName relation: Read activity_labels.txt.
- Assign ActivityName by matching observation ActivityId.

4.SET DESCRIPTIVE VARIABLE(FEATURE) NAMES
- Relation featureId - featureName is already obtained and required features already are filtered.
- Assign featureNames.

5.CREATE FINAL TIDY DATA SET WITH THE AVERAGE OF EACH VARIABLE FOR EACH ACTIVITY AND EACH SUBJECT
- Get SubjectId for each oservation: Read subject_train.txt and subject_test.txt, append.
- Add subjectId column for further aggregation
- Create data.frame with  aggregation by Activity and then subjectId.
- Save final data.frame as space delimited file in workspace subdirectory.
        
       
#####FINAL TIDY DATA SET DESCRIPTION

Final tidy data set contains 6 x 30 = 180 agregated by activites(6) and subjects(30)observations
of 79 features (reduced by including ones with name containg "mean" or "std")
and consists of 1 space-delmited file with column headers and descriptive activity names:
tidy/tidy.txt      
This file can be read back to R like this:
dfCheck <- read.table(file.path(getwd(),"tidy","tidy.txt"), header=TRUE)

