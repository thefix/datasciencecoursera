###############################################################################
#
# Getting and Cleaning Data Project
#
#
###################################JMF########################################

# load stringr package
#
#uses function string_detect
#

library(stringr)


# load plyr package
#
#uses function ddply
#

library(plyr)

# read the 8 tables of data into 8 data frames

x_test<-read.table("X_test.txt", sep="")    # observations in test set
x_train<-read.table("X_train.txt", sep="")  # observations in training set

y_test<-read.table("y_test.txt", sep="")    #
y_train<-read.table("y_train.txt", sep="")  #

subject_test<-read.table("subject_test.txt", sep="")    # table of subject ids for the observations in test set
subject_train<-read.table("subject_train.txt", sep="")  # table of subject ids for the observations in training set

features<-read.table("features.txt", sep="")                  # variable number and names
activity_labels<-read.table("activity_labels.txt", sep="")    # activity number and names


# when we look at the dim of all those data frames we realize that
# there are 561 variables
# there are 6 activities
# there are 7352 observations in training and 2947 in test
#

# add the subject as the first column of their respective observations

test_set<-cbind(subject_test,y_test,x_test)
train_set<-cbind(subject_train,y_train,x_train)

#rename the first column of each as subject

names(test_set)[1]<-"subject"
names(train_set)[1]<-"subject"

# combine the two sets

data_set<-rbind(train_set,test_set)

f<-as.vector(features$V2)  #transform variable names in a vector

#create a new data frame extracted from features where mean is in the name

mean_num<-which(str_detect(f,"mean"))
features_mean<-features[mean_num,]   

#create a new data frame extracted from features where Mean is in the name

Mean_num<-which(str_detect(f,"Mean"))
features_Mean<-features[Mean_num,] 

#create a new data frame extracted from features where std is in the name

std_num<-which(str_detect(f,"std"))
features_std<-features[std_num,] 

#picks the first, second and all the columns containing mean, std #and Mean 

tidy_mean_std<-data_set[,c(1,2,2+features_mean$V1,2+features_std$V1, 2+features_Mean$V1)]  


#rename the variables

fmv2<-c(as.vector(features_mean$V2),as.vector(features_std$V2),as.vector(features_Mean$V2))
var_names<-c("subject","activity",fmv2)
names(tidy_mean_std)<-var_names

#rename the activities from number to corresponding text

activity_text<-activity_labels[tidy_mean_std[,2],]
tidy_mean_std[,2]<-activity_text[,2]

#extract the means for all subject activity combination

finaltidy_mean_by_activity_by_subject<-ddply(tidy_mean_std, .(subject, activity), colwise(mean))


#need to rename all vars to mean_of_oldname




