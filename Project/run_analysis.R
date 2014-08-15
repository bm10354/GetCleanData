#1.Merge training and test sets to create one data set
dfTrain <- read.table(file.path(getwd(), "train", "X_train.txt"))
dfTest <- read.table(file.path(getwd(), "test", "X_test.txt"))
dfAll <- rbind(dfTrain, dfTest)

#2.Extract only mean and standard deviation for each measurement
dfFeatures <- read.table(file.path(getwd(),"features.txt"))
iFeatures <- grep("mean|std", dfFeatures$V2)
dfAllReq <- dfAll[,iFeatures]

#3.Use descriptive activity names
dfTrainActivities <- read.table("train/y_train.txt")
dfTestActivities <- read.table("test/y_test.txt")
dfAllActivities <- rbind(dfTrainActivities, dfTestActivities)
dfActivityNames <- read.table("activity_labels.txt")
dfAllActivities$activityName <- factor(dfAllActivities$V1, levels = labels$V1, labels = labels$V2)
dfAllReq <- cbind(dfAllReq, dfAllActivities$activityName )
names(dfAllReq)[names(dfAllReq) == "dfAllActivities$activityName"] <- "Activity"

#4. Set descriptive variable names
names(dfAllReq)[1:(ncol(dfAllReq)-1)] = as.character(dfFeatures$V2[iFeatures])
