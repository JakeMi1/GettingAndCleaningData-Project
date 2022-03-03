library(dplyr)

# Read all files & assign column names

readfiles <- function() {
    subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = "Subject")
    subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = "Subject")
    features <- read.table('./UCI HAR Dataset/features.txt')
    activity_labels = read.table('./UCI HAR Dataset/activity_labels.txt', col.names = c("ActId","ActName"))
    x_train <- read.table("./UCI HAR Dataset/train/X_train.txt", col.names = features[,2])
    y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", col.names = "ActID")
    x_test <- read.table("./UCI HAR Dataset/test/X_test.txt", col.names = features[,2])
    y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names = "ActID")
}

readfiles()

# Merge data into a single dataset

train <- cbind(subject_train, y_train, x_train)
test <- cbind(subject_test, y_test, x_test)
merged <- rbind(train, test)

# Select only mean and std measurements, then replace activity ID with descriptive activity names

mean_std <- merged %>% 
    select(Subject, ActID, contains("mean"), contains("std")) %>%
    mutate("Activity" = activity_labels[merged$ActID, 2], ActID = NULL, .after = "Subject")

# Apply descriptive labels

names(mean_std)<-gsub("Acc", "Accelerometer", names(mean_std))
names(mean_std)<-gsub("Gyro", "Gyroscope", names(mean_std))
names(mean_std)<-gsub("BodyBody", "Body", names(mean_std))
names(mean_std)<-gsub("Mag", "Magnitude", names(mean_std))
names(mean_std)<-gsub("^t", "Time", names(mean_std))
names(mean_std)<-gsub("^f", "Frequency", names(mean_std))
names(mean_std)<-gsub("tBody", "TimeBody", names(mean_std))
names(mean_std)<-gsub("-mean()", "Mean", names(mean_std), ignore.case = TRUE)
names(mean_std)<-gsub("-std()", "STD", names(mean_std), ignore.case = TRUE)
names(mean_std)<-gsub("-freq()", "Frequency", names(mean_std), ignore.case = TRUE)
names(mean_std)<-gsub("angle", "Angle", names(mean_std))
names(mean_std)<-gsub("gravity", "Gravity", names(mean_std))

# Create new dataset with mean of each variable for each Subject and Activity

final <- mean_std %>%
    group_by(Subject, Activity) %>%
    summarise_all(mean)

# Write final dataset into TXT file

write.table(final, "Galaxy_S_data.txt", row.name=FALSE)
