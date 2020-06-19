# Human Activity Recognition Using Smartphones Data Set

This project is conducted as an assignment for the Coursera course *Getting and Cleaning Data*. It aims at restructuring the data set that can be found
[here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones){target="_blank"}. This document is a code book that describes the variables, the data, and any transformations or work that I performed to clean up the data and obtain a tidy data set. In the following sections, I describe how the original data frames have been manipulated and converted into the final output. 

### First merging of data sets (task 1)
In order to carry out this task I proceeded as follows:

1. The feature names to be used as column names are extracted from the file <tt>features.txt</tt>.  
2. The main data frames are extracted from the files <tt>X_train.txt</tt> and <tt>X_test.txt</tt>.  
3. The activities are extracted from the files <tt>y_train.txt</tt> and <tt>y_test.txt</tt> and are added as column to the respective train and test data frames.  
4. The activities are extracted from the files <tt>subject_train.txt</tt> and <tt>subject_test.txt</tt> and are added as column to the respective train and test data frames.   
5. The train and test data frames are finally concatenated. This produces a data frame with dimension 10299 x 81. The number of rows matches the number given by the authors in the web page of the original project (number of instances). Due to the feature selection, the number of columns went from the original 561 to 81 (79 measurements, plus 1 column for the activity and 1 for the subject).

### Feature selection (task 2)
The assignment states:
*Extracts only the measurements on the mean and standard deviation for each measurement.*  
According to this enlightening [post](https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/){target="_blank"}, the criteria for selecting relevant features are somewhat vague and arbitrary in the assignment.
There is no ambiguity as far as the string <tt>std()</tt> is concerned.
However, it is an open question whether the requirement refers only to the entries that include <tt>mean()</tt> at the end, or to all the entries with <tt>mean</tt>, even if it occurs in an earlier part of the name, e.g. <tt>fBodyAccMag-meanFreq()</tt>. I went for the latter option, which results in 79 features. The data contained in the folders <tt>Inertial Signals</tt> are not relevant and are therefore excluded from the process.

### Renaming activities (task 3)
The activities are imported from the file <tt>activity_labels.txt</tt>. The text is converted to lowercase and underscores are replaced by white space.

### Variable names (task 4)
In renaming the variables, I removed the parentheses at the end of the string and I decided to convert the dashes into dots, since just removing them would worsen readability. 
The course lecture *Editing text variables* illustrates some methods to remove underscores and dots in variable names. This does not imply that having those symbols in the name is wrong *per se*. In fact, the R function <tt>make.names</tt>, which makes syntactically valid names out of character vectors, converts most weird characters to dots. A look at <tt>?make.names</tt> reveals that "a syntactically valid name consists of letters, numbers and the dot or underline characters and starts with a letter or the dot not followed by a number". The reason why you might want to remove dots and underscores is if you want to use the variable names for some subsequent purposes that require the names to be written in a specific way. I used the following post as reference:

https://www.r-bloggers.com/consistent-naming-conventions-in-r/

I noticed that keeping the dashes might cause some problems, for example when trying to show a variable with the format df$var. As far as the descriptiveness of the names is concerned, I decided not to alter the original variables. On the one hand, it is true that a name like <tt>fBodyAccJerk.mean.Z</tt> may not be highly descriptive. On the other hand, attempts to make it more descriptive might result in eccessive verbosity. In any case, it is assumed that the data frame will be used in conjunction with the code book, which helps interpreting the variable names.

### Creation of the final data set (task 5)
The assignment states:
*From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.*
In order to do this, I reshaped the variable <tt>activity</tt> so as to form the second column of the new data frame. Since there are 30 subjects (21 in the train set and 9 in the test set) and 6 activities, the result is a data frame with 180 rows (30 x 6). For example, row 1 displays the mean of each feature (there are 79 features in total) for the activity *laying* for subject 1, and the value for the feature *tBodyAcc-mean-X* represents the mean of the different measurements of that variable for the combination subject 1 / activity=laying. This raises the question whether it makes sense to compute the mean of standard deviations. As suggested in the already mentioned [post](https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment/){target="_blank"},
"it doesn’t matter, you are being asked to produce an average for each combination of subject, activity, and variable as a sign you can manipulate the data".


### Description of variables

As described by the authors in their code book, the features selected for the original database come from the accelerometer and gyroscope 3-axial raw signals <tt>tAcc-XYZ and tGyro-XYZ</tt>. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (<tt>tBodyAcc-XYZ and tGravityAcc-XYZ</tt>) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (<tt>tBodyAccJerk-XYZ</tt> and <tt>tBodyGyroJerk-XYZ</tt>). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (<tt>tBodyAccMag</tt>, <tt>tGravityAccMag</tt>, <tt>tBodyAccJerkMag</tt>, <tt>tBodyGyroMag</tt>, <tt>tBodyGyroJerkMag</tt>). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing <tt>fBodyAcc-XYZ</tt>, <tt>fBodyAccJerk-XYZ</tt>, <tt>fBodyGyro-XYZ</tt>, <tt>fBodyAccJerkMag</tt>, <tt>fBodyGyroMag</tt>, <tt>fBodyGyroJerkMag</tt>. (Note the 'f' to indicate frequency domain signals). 

Using all the signals described above, the authors proceed to compute various summary variables such as mean, standard deviation (std), minimum and maximum value, interquartile range etc. For the purposes of the assignement, only mean and standard deviation are selected as relevant features.
This results in the following list of features:


```
##  [1] "tBodyAcc.mean.X"               "tBodyAcc.mean.Y"               "tBodyAcc.mean.Z"              
##  [4] "tBodyAcc.std.X"                "tBodyAcc.std.Y"                "tBodyAcc.std.Z"               
##  [7] "tGravityAcc.mean.X"            "tGravityAcc.mean.Y"            "tGravityAcc.mean.Z"           
## [10] "tGravityAcc.std.X"             "tGravityAcc.std.Y"             "tGravityAcc.std.Z"            
## [13] "tBodyAccJerk.mean.X"           "tBodyAccJerk.mean.Y"           "tBodyAccJerk.mean.Z"          
## [16] "tBodyAccJerk.std.X"            "tBodyAccJerk.std.Y"            "tBodyAccJerk.std.Z"           
## [19] "tBodyGyro.mean.X"              "tBodyGyro.mean.Y"              "tBodyGyro.mean.Z"             
## [22] "tBodyGyro.std.X"               "tBodyGyro.std.Y"               "tBodyGyro.std.Z"              
## [25] "tBodyGyroJerk.mean.X"          "tBodyGyroJerk.mean.Y"          "tBodyGyroJerk.mean.Z"         
## [28] "tBodyGyroJerk.std.X"           "tBodyGyroJerk.std.Y"           "tBodyGyroJerk.std.Z"          
## [31] "tBodyAccMag.mean"              "tBodyAccMag.std"               "tGravityAccMag.mean"          
## [34] "tGravityAccMag.std"            "tBodyAccJerkMag.mean"          "tBodyAccJerkMag.std"          
## [37] "tBodyGyroMag.mean"             "tBodyGyroMag.std"              "tBodyGyroJerkMag.mean"        
## [40] "tBodyGyroJerkMag.std"          "fBodyAcc.mean.X"               "fBodyAcc.mean.Y"              
## [43] "fBodyAcc.mean.Z"               "fBodyAcc.std.X"                "fBodyAcc.std.Y"               
## [46] "fBodyAcc.std.Z"                "fBodyAcc.meanFreq.X"           "fBodyAcc.meanFreq.Y"          
## [49] "fBodyAcc.meanFreq.Z"           "fBodyAccJerk.mean.X"           "fBodyAccJerk.mean.Y"          
## [52] "fBodyAccJerk.mean.Z"           "fBodyAccJerk.std.X"            "fBodyAccJerk.std.Y"           
## [55] "fBodyAccJerk.std.Z"            "fBodyAccJerk.meanFreq.X"       "fBodyAccJerk.meanFreq.Y"      
## [58] "fBodyAccJerk.meanFreq.Z"       "fBodyGyro.mean.X"              "fBodyGyro.mean.Y"             
## [61] "fBodyGyro.mean.Z"              "fBodyGyro.std.X"               "fBodyGyro.std.Y"              
## [64] "fBodyGyro.std.Z"               "fBodyGyro.meanFreq.X"          "fBodyGyro.meanFreq.Y"         
## [67] "fBodyGyro.meanFreq.Z"          "fBodyAccMag.mean"              "fBodyAccMag.std"              
## [70] "fBodyAccMag.meanFreq"          "fBodyBodyAccJerkMag.mean"      "fBodyBodyAccJerkMag.std"      
## [73] "fBodyBodyAccJerkMag.meanFreq"  "fBodyBodyGyroMag.mean"         "fBodyBodyGyroMag.std"         
## [76] "fBodyBodyGyroMag.meanFreq"     "fBodyBodyGyroJerkMag.mean"     "fBodyBodyGyroJerkMag.std"     
## [79] "fBodyBodyGyroJerkMag.meanFreq"
```

As mentioned above in *Creation of the final data set (task 5)*, the output data frame shows in each column the mean of all the measurements of a particular variable for a given combination of subject and activity. One choice that I have made is not to make the variable name too intricate by adding *mean* to the already existing name. This would change <tt>tBodyAcc.mean.X</tt> to <tt>tBodyAcc.mean.X.mean</tt>, which is in my opinion confusing. It will suffice to be aware of the fact that all the measurements in the final data set are average (mean) measurements. This means that, for example, the variable <tt>tBodyAcc.mean.X</tt> represents the mean of all the mean values of body acceleration (time domain signal) along the X axis for a given pair subject-activity.


