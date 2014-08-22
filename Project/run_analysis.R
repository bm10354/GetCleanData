
#1.MERGE TRAINING AND TEST SETS TO CREATE ONE DATA SET
dfTrain <- read.table(file.path(getwd(), "train", "X_train.txt"))
dfTest <- read.table(file.path(getwd(), "test", "X_test.txt"))
dfAll <- rbind(dfTrain, dfTest)

#2.EXTRACT ONLY MEAN AND STANDARD DEVIATION FOR EACH MEASUREMENT
dfFeatures <- read.table(file.path(getwd(), "features.txt"))
iFeatures <- grep("mean|std", dfFeatures$V2)
dfAllReq <- dfAll[,iFeatures]

#3.USE DESCRIPTIVE ACTIVITY NAMES
dfTrainActivities <- read.table(file.path(getwd(), "train", "y_train.txt"))
dfTestActivities <- read.table(file.path(getwd(), "test", "y_test.txt"))
dfAllActivities <- rbind(dfTrainActivities, dfTestActivities)
dfActivityNames <- read.table(file.path(getwd(), "activity_labels.txt"))
dfAllActivities$activityName <- factor(dfAllActivities$V1, levels = dfActivityNames$V1, labels = dfActivityNames$V2)
dfAllReq <- cbind(dfAllActivities$activityName, dfAllReq )
###names(dfAllReq)[names(dfAllReq) == "dfAllActivities$activityName"] <- "Activity"
names(dfAllReq)[1] <- "Activity" #faster and more reiliable than line above

#4.SET DESCRIPTIVE VARIABLE(FEATURE) NAMES
names(dfAllReq)[2:(ncol(dfAllReq))] = as.character(dfFeatures$V2[iFeatures])

#5.CREATE FINAL TIDY DATA SET WITH THE AVERAGE OF EACH VARIABLE FOR EACH ACTIVITY AND EACH SUBJECT
##5.1. Add subjectId column for further aggregation
dfSubjectTrain <- read.table(file.path(getwd(), "train", "subject_train.txt"))
dfSubjectTest <- read.table(file.path(getwd(), "test", "subject_test.txt"))
dfSubject <- rbind(dfSubjectTrain, dfSubjectTest)
dfAllReq <- cbind(dfSubject, dfAllReq)
names(dfAllReq)[1] <- "subjectId"

##5.2.Create data.frame with  aggregation by Activity and then subjectId
dfTidy <- aggregate(dfAllReq[,3:81], by = list(dfAllReq$Activity, dfAllReq$subjectId), FUN = mean)
names(dfTidy)[1:2] <- c("Activity", "subjectId")
dfTidy <- dfTidy[order(dfTidy$Activity),]

##5.3.Save final data.frame as space delimited file in workspace subdirectory
dir.create("tidy", showWarnings = FALSE)
write.table(dfTidy, file=file.path(getwd(),"tidy","tidy.txt"), sep=" ", row.names=FALSE)
