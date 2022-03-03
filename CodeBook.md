---
title: "CodeBook"
author: "Jake Mitchell"
date: "3/2/2022"
output: html_document
---

# Getting and Cleaning Data Project

The `run_analysis.R` code transforms the provided raw Samsung Galazy S data

- Combines files into a single dataset
- Extracts only the measurements on the mean and standard deviation for each measurement
- Adds descriptive activity names in place of activity ID
- Labels data with descriptive column names
- Creates a dataset with the average of each variable for each activity and each subject

## Variables:   
- `x_train`, `y_train`, `x_test`, `y_test`, `subject_train` and `subject_test` contain the data from the downloaded files.
- `features` contains the column headers for the x_train/x_test datasets
- `train` and `test` merge columns of the datasets. The rows of these are then merged into the `merged` dataset.
- `mean_std` contains just the measurements on the mean and standard deviation for each measurement, with ActID replaced by Activity.
- `final` contains the average of each variable for each activity and each subject.
