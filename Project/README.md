#### Purpose
demonstrate ability to collect, work with, and clean a data set
to complete Project for __Getting and Cleaning Data__ Coursera class.

#### Content
- __CodeBook.md__ is the description of the variables, the data, and transformations performed to clean up data
- __run_analysis.R__ is the R implementation of data transformations.

#### Reproduction steps
1.Source data preparation 
Download and unzip file from [here]
(https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) 
The result is the local disk (sub)directory named UCI HAR Dataset, containing the source data files and subdirectories
Thise can be done with any tools of choice, not necessary within R.

2.R program preparation
Download run_analysis.R from this repository so it is available for R (R Studio).
It is not necessary to put it in UCI HAR Dataset.

3.R program execution
Set working R (R Studio) working directory to UCI HAR Dataset and execute run_analysis.R
