##Input the X_Train and X_Test Files
X_Train<-read.table("C:/Users/srikrish/Downloads/UCI HAR Dataset/train/X_train.txt",sep="",col.names=(1:561),fill=FALSE,strip.white=TRUE)
X_Test<-read.table("C:/Users/srikrish/Downloads/UCI HAR Dataset/test/X_test.txt",sep="",col.names=(1:561),fill=FALSE,strip.white=TRUE)
##Input the Y_Train and Y_Test Files
Y_Train<-read.table("C:/Users/srikrish/Downloads/UCI HAR Dataset/train/Y_train.txt",sep="",col.names=("Activity_Labels"),fill=FALSE,strip.white=TRUE)
Y_Test<-read.table("C:/Users/srikrish/Downloads/UCI HAR Dataset/test/Y_test.txt",sep="",col.names=("Activity_Labels"),fill=FALSE,strip.white=TRUE)
##Input the Subject Train and Test Files
Subject_Train<-read.table("C:/Users/srikrish/Downloads/UCI HAR Dataset/train/subject_train.txt",sep="",col.names=("Subjects"),fill=FALSE,strip.white=TRUE)
Subject_Test<-read.table("C:/Users/srikrish/Downloads/UCI HAR Dataset/test/subject_test.txt",sep="",col.names=("Subjects"),fill=FALSE,strip.white=TRUE)

##Check the Dimensions of the Input Data sets for further Appending purposes
dim(X_Train)
dim(X_Test)
dim(Y_Train)
dim(Y_Test)
dim(Subject_Train)
dim(Subject_Test)

##Appending both Subject_Train and Y_Train with X_Train Dataset
Train<-cbind(Subject_Train,Y_Train,X_Train)
Test<-cbind(Subject_Test,Y_Test,X_Test)
dim(Train)
dim(Test)

##Merging the Train and Test Datasets
Final<-rbind(Train,Test)
Final<-Final[order(Final$Subjects,Final$Activity_Labels),]
head(Final[,1:2])
dim(Final)

##Extract only the Mean and Standard Deviation for Each Measurement
variables=c(1:2,3:8,43:48,83:88,123:128,163:168,203:204,216,217,229,230,242,243,255,256,268:273,347:352,426:431,505:506,518,519,531,532,544,545)
Final_mean_sdv<-Final[,variables]

##Naming the Activity Labels
Final_mean_sdv$Activity_Labels<-factor(Final_mean_sdv$Activity_Labels,levels=c(1,2,3,4,5,6),labels=c("Walking","Walking_Upstairs","Walking_Downstairs","Sitting","Standing","Laying"))
str(Final_mean_sdv)

##Label the Dataset with Descriptive Variable Names
names(Final_mean_sdv)  ##Original Variable Names
names(Final_mean_sdv)<-c("Subjects","Activity_Labels","tBodyAcc-meanX","tBodyAcc-meanY","tBodyAcc-meanZ","tBodyAcc-stdX","tBodyAcc-stdY","tBodyAcc-stdZ","tGravityAcc-meanX","tGravityAcc-meanY","tGravityAcc-meanZ","tGravityAcc-stdX","tGravityAcc-stdY","tGravityAcc-stdZ","tBodyAccJerk-meanX","tBodyAccJerk-meanY","tBodyAccJerk-meanZ","tBodyAccJerk-stdX","tBodyAccJerk-stdY","tBodyAccJerk-stdZ","tBodyGyro-meanX","tBodyGyro-meanY","tBodyGyro-meanZ","tBodyGyro-stdX","tBodyGyro-stdY","tBodyGyro-stdZ","tBodyGyroJerk-meanX","tBodyGyroJerk-meanY","tBodyGyroJerk-meanZ","tBodyGyroJerk-stdX","tBodyGyroJerk-stdY","tBodyGyroJerk-stdZ","tBodyAccMag-mean","tBodyAccMag-std","tGravityAccMag-mean","tGravityAccMag-std","tBodyAccJerkMag-mean","tBodyAccJerkMag-std","tBodyGyroMag-mean","tBodyGyroMag-std","tBodyGyroJerkMag-mean","tBodyGyroJerkMag-std","fBodyAcc-meanX","fBodyAcc-meanY","fBodyAcc-meanZ","fBodyAcc-stdX","fBodyAcc-stdY","fBodyAcc-stdZ","fBodyAccJerk-meanX","fBodyAccJerk-meanY","fBodyAccJerk-meanZ","fBodyAccJerk-stdX","fBodyAccJerk-stdY","fBodyAccJerk-stdZ","fBodyGyro-meanX","fBodyGyro-meanY","fBodyGyro-meanZ","fBodyGyro-stdX","fBodyGyro-stdY","fBodyGyro-stdZ","fBodyAccMag-mean","fBodyAccMag-std","fBodyBodyAccJerkMag-mean","fBodyBodyAccJerkMag-std","fBodyBodyGyroMag-mean","fBodyBodyGyroMag-std","fBodyBodyGyroJerkMag-mean","fBodyBodyGyroJerkMag-std")
names(Final_mean_sdv) ##After Variables Names Assigned

##Second Dataset with Average of Each variable with Each Activity and Each Subject

dim(Final_mean_sdv)
attach(Final_mean_sdv)
Aggreg_Final_mean_sdv<-aggregate(Final_mean_sdv,by=list(Subjects,Activity_Labels),FUN=mean,na.rm=TRUE)
detach(Final_mean_sdv)

Aggreg_Final_mean_sdv$Group.1->Aggreg_Final_mean_sdv$Subjects
Aggreg_Final_mean_sdv$Group.2->Aggreg_Final_mean_sdv$Activity_Labels
Aggreg_Final_mean_sdv$Group.1<-NULL
Aggreg_Final_mean_sdv$Group.2<-NULL
str(Aggreg_Final_mean_sdv)

##Editing Text Variables
tolower(names(Aggreg_Final_mean_sdv)) ##Lower case of all the variable names

##Final Data Set for Submission for Question No. 5
head(Aggreg_Final_mean_sdv)
write.table(Aggreg_Final_mean_sdv,"Final_Submission.txt",sep=c(' ', ' ', '\n'),row.name=FALSE)


