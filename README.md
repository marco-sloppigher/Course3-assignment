# Human Activity Recognition Using Smartphones Data Set

This project is conducted as an assignment for the Coursera course *Getting and Cleaning Data*. It aims at restructuring a data set that can be found
[here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).  
This repository includes the following files:  

1. <tt>run_analysis.R</tt>: the script that selects relevant features and manipulates the original data set so as to display the average of each variable for each *activity* and each *subject*  
2. <tt>Course3_assignment.txt</tt>: the output data frame, the same that can be found in my submission  
3. <tt>CodeBook.md</tt>: a code book that describes the variables, the data, and any transformations or work that I performed to clean up the data  

In order to run the script <tt>run_analysis.R</tt>, make sure that <tt>UCI_HAR_Dataset</tt> is set as working directory, so that all the necessary data sets can be properly imported.

You can import the table that I have created (<tt>Course3_assignment.txt</tt>) with the following command:


```r
data <- read.table("Course3_assignment.txt", header=TRUE)
View(data)
```

