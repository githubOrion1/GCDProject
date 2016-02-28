README

run_Analysis.R imports and combines the test and training datasets from the UCI HAR Dataset of Samsung smartphone data.

The script reads the files from a folder named “UCI HAR Dataset” which is further organized into “/test” and “/train”.

The script appends the subject and activity for each measurement for both the test and training data sets.

The “UCI HAR Dataset/features.txt” file is used to name the features of each measurement.

The “UCI HAR Dataset/activity_labels.txt” file is used to name the activity levels of the activity factor.

Features that are not either a mean or standard deviation are removed using a regular expression, reducing the number of variables in the dataset to 86 features plus the subject and activity (subject and activity are factors, the feature variables are numeric).

Finally, a summary dataset is created by generating a mean for each of the remaining features for each subject and activity. This dataset is written to a txt file.