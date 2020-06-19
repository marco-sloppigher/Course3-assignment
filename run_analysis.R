library(data.table)

# Import file with activity names
activities <- read.table("activity_labels.txt")
activity_names <- tolower(gsub("_", " ", activities$V2))
activity_id <- as.character(activities$V1)

# Create lookup table to convert the activity index into a descriptive activity name
lookup = setNames(activity_names, activity_id)

# Import files with features, subject IDs and labels (train set)
X_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")
y_train <- transform(y_train, activity.name=lookup[V1], stringsAsFactors=FALSE)
subject_train <- read.table("train/subject_train.txt", col.names = "subject")

# Import files with features, subject IDs and labels (test set)
X_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")
y_test <- transform(y_test, activity.name=lookup[V1], stringsAsFactors=FALSE)
subject_test <- read.table("test/subject_test.txt", col.names = "subject")

# Import file with feature names and extract relevant features
# (mean and standard deviation for each measurement)
features <- read.table("features.txt")
features_relevant <- features[grep("(-mean|-std)", features$V2), ]
features_names_relevant <- as.character(features_relevant$V2)
features_names_relevant <- gsub("\\(\\)", "", features_names_relevant)
features_names_relevant <- gsub("-", ".", features_names_relevant)

# Select relevant columns from train set
train_1 <- X_train[, features_relevant$V1]
train_2 <- setnames(train_1, old = names(train_1), new = features_names_relevant)
train_3 <- cbind(train_2, subject_train, activity=y_train$activity.name)

# Select relevant columns from test set
test_1 <- X_test[, features_relevant$V1]
test_2 <- setnames(test_1, old = names(test_1), new = features_names_relevant)
test_3 <- cbind(test_2, subject_test, activity=y_test$activity.name)

# Concatenate train and test set to create one data frame
df <- rbind(train_3, test_3)

# Create a new data frame with the mean of each feature 
# for each combination of subject-activity
df_agg <- aggregate(df[, c(1:79)], list(subject=df$subject, activity=df$activity), mean)

# Create output file
write.table(df_agg, file="Course3_assignment.txt", row.names = FALSE)
