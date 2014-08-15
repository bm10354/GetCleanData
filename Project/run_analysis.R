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
dfAllActivities$activityName <- factor(dfAllActivities$V1, levels = dfActivityNames$V1, labels = dfActivityNames$V2)
dfAllReq <- cbind(dfAllActivities$activityName, dfAllReq )
##names(dfAllReq)[names(dfAllReq) == "dfAllActivities$activityName"] <- "Activity"
names(dfAllReq)[1] <- "Activity"

#4. Set descriptive variable names
names(dfAllReq)[2:(ncol(dfAllReq))] = as.character(dfFeatures$V2[iFeatures])

#5. Create tidy data set with the average of each variable for each activity and each subject
dfSubjectTrain <- read.table(file.path("train", "subject_train.txt"))
dfSubjectTest <- read.table(file.path("test", "subject_test.txt"))
dfSubject <- rbind(dfSubjectTrain, dfSubjectTest)
dfAllReq <- cbind(dfSubject, dfAllReq)
names(dfAllReq)[1] <- "subjectId"

dfTidy <- aggregate(dfAllReq[,3:81], by = list(dfAllReq$Activity, dfAllReq$subjectId), FUN = mean)
names(dfTidy)[1:2] <- c("Activity", "subjectId")
attach(dfTidy)
dfTidy <- dfTidy[order(Activity),]
detach(dfTidy)
