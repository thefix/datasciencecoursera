READ ME file for Getting and Cleaning Data Coursera course project

#Goal: create two tidy data frames
-tidy_mean_std
-finaltidy_mean_by_activity_by_subject

A tidy data frame must have the following characteristics:
-Each variable is in one column
-Each different observation of that variable is in a different row
-There is one table for each kind of varaible. Here ale the variables are related to the same set of observations so there is only one table

See component of tidy data slide 4

#Exploration of the data shows that
X_test.txt and X_train.txt contain the observations for 561 variables. The rows are character representation of double precision numbers between -1 and 1.

y_test.txt and y_train.txt contain the activities (6 possible activities). They have the same number of rows of their corresponding X_test/train.txt above.

subject_test.txt and subject_train.txt contain the subjectsthat did the activities. They have the same number of rows of their corresponding X_test/train.txt above.

It is not explicitely stated but we assume that all the files contain the data in the same order. That is the first numebr of subject_test.txt contians the id of the subject that did the activity in the first row of y_test.txt and had the observations in X_test.txt.

In addition becuase of the assignment we need to extract the names relating to mean and standard deviation. We assume that they contain the word mean and std in all different capitalization possible. Looking at the data we see that we have the strings "mean", "Mean" and "Std" as the only three possibilities.
No data is NA or missing.

#@@@@@@@@@@@@@@@@Process@@@@@@@@@@@@@@@@@@@@@@@@@@@

1. load stringr package to be able to use function string_detect

2. load plyr package to use functions ddply and mapvalues

3. read the 8 tables of data into 8 data frames (as numeric for the first 6 and as characters for the last two)

	x_test contains X_test.txt (observations in test set)

	x_train contains X_train.txt (observations in training 	set)

	y_test contains y_test.txt (activities in test set)

	y_train contains y_training.txt (activities in training set)

	subject_test contains subject_test.txt (subjects ids for the observations in test set)

	subject_train contains subject_train.txt (subjects ids for the observations in training set)

	features contains features.txt (variable number and names)
activity_labels contains activity_labels.txt"(activity number and names)


When we look at the dim of all those data frames we realize that
-there are 561 variables
-there are 6 activities
-there are 7352 observations in training and 2947 in test


4. add the subject as the first column and activities as the second column of their respective observations using cbind

test_set<-cbind(subject_test,y_test,x_test)
train_set<-cbind(subject_train,y_train,x_train)

5. rename the first column of each as subject

6. combine the two sets in one big data frame called data_set containing first the rows of train_set and then the rows of test_set using rbind

7. transform variable names (the second column of features) in a vector f

8. create a new data frame extracted from features where mean is in the name by using str_detect of "mean" on f (the vector of all names) and extrating the names in features_mean.

9. create a new data frame extracted from features where Mean is in the name by using str_detect of "Mean" on f (the vector of all names) and extrating the names in features_Mean.

10. create a new data frame extracted from features where Mean is in the name by using str_detect of "std" on f (the vector of all names) and extrating the names in features_std.

11. extract from data_set all the columns indexed in the three vectors of names in step 8,9 and 10 plus column 1 (subject id) and 2 (activities) and put them in a data set called tidy_mean_std. 
The order of the collumn is subject, activity, column containing mean in their name, tables containing std in their names and finally columns containing Mean in their names.

12. rename all the variables in tidy_mean_std with their proper character name. I found the name explicit enough and left them alone

This data set has 88 columns and the same number of rows as data_set.

13. replace the activity codes by the activity name

14. calculate the means for all subject activity combination and create a data frame (called finaltidy_mean_by_activity_by_subject)





