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
# there are 7352 observations in tesin and 2947 in test
#

# add the subject as the first column of their respective observations

test_set<-cbind(y_test,x_test)
train_set<-cbind(y_train,x_train)

#rename the first column of each as subject

names(test_set)[1]<-"subject"
names(train_set)[1]<-"subject"

# combine the two sets

data_set<-rbind(train_set,test_set)

f<-as.vector(features$V2)  #transform variable names in a vector

#create a new data frame extracted from features where mean is in the name

mean_num<-which(str_detect(f,"mean"))
features_mean<-features[mean_num,]   


#create a new data frame extracted from features where std is in the name

std_num<-which(str_detect(f,"std"))
features_std<-features[std_num,] 


tidy<-data_set[,c(1,1+features_mean$V1,1+features_std$V1)]  #picks the first and all the mean #JMF (and later std) cols

#name the variables

fmv2<-c(as.vector(features_mean$V2),as.vector(features_std$V2))
var_names<-c("subject",fmv2)
names(tidy)<-var_names



#test if anything is NA


