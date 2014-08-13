#1.Merge training and test sets to create one data set
dfTrain <- read.table(file.path(getwd(), "train", "X_train.txt"))
dfTest <- read.table(file.path(getwd(), "test", "X_test.txt"))
dfAll <- rbind(dfTrain, dfTest)
#rm(dfTrain)
#rm(dfTest)

#2.Extract only mean and standard deviation for each measurement
dfFeatures <- read.table(file.path(getwd(),"features.txt"))
iFeatures <- grep("mean|std", dfFeatures$V2)
dfAllReq <- dfAll[,iFeatures]

#3.Use descriptive activity names
