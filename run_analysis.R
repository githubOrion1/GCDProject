# Ryan Squires
# 24 Feb 2016

library(dplyr)

f.df <- read.table("UCI HAR Dataset/features.txt",
                        col.names=c("fNo","feature"),
                       header=FALSE)

features <- f.df$feature

rm(f.df)

# load and subset test set

x.test <- read.table("UCI HAR Dataset/test/X_test.txt", 
                     col.names=features)

x1.test <- select(x.test, matches("*mean*|*std*"))

rm(x.test)

subj.test <- read.table("UCI HAR Dataset/test/subject_test.txt",
                    col.names=c("subject"))

y.test <- read.table("UCI HAR Dataset/test/y_test.txt",
                     col.names=c("activity"))

c.test <- cbind(subj.test,y.test,x1.test)

rm(list=c("y.test","subj.test","x1.test"))

# load and subset training set

x.train <- read.table("UCI HAR Dataset/train/X_train.txt", 
                     col.names=features)

x1.train <- select(x.train, matches("*mean*|*std*"))

rm(x.train)

subj.train <- read.table("UCI HAR Dataset/train/subject_train.txt",
                        col.names=c("subject"))

y.train <- read.table("UCI HAR Dataset/train/y_train.txt",
                     col.names=c("activity"))

c.train <- cbind(subj.train,y.train,x1.train)

rm(list=c("y.train","subj.train","x1.train"))

# combine datasets

test_train <- rbind(c.test, c.train)

test_train$subject <- as.factor(test_train$subject)

a.df <- read.table("UCI HAR Dataset/activity_labels.txt",
                   col.names=c("activityNo","activity"),
                   header=FALSE)

activity_labels=a.df$activity

test_train$activity <- factor(test_train$activity,labels=activity_labels)

rm(list=c("c.test","c.train","features","a.df","activity_labels"))

# summary dataset

mean_by_factors <- group_by(test_train, subject, activity) %>% summarize_each(funs(mean))

# generate text file of dataset

write.table(mean_by_factors, file="ds.txt", row.names=FALSE)
