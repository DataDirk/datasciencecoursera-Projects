---
title: "Practical Machine Learning Course Project"
output: 
  html_document:
    keep_md: true
---



## Introduction

It is now possible to collect a large amount of data about personal
movement using activity monitoring devices such as a
[Fitbit](http://www.fitbit.com), [Nike
Fuelband](http://www.nike.com/us/en_us/c/nikeplus-fuelband), or
[Jawbone Up](https://jawbone.com/up). These type of devices are part of
the "quantified self" movement -- a group of enthusiasts who take
measurements about themselves regularly to improve their health, to
find patterns in their behavior, or because they are tech geeks. But
these data remain under-utilized both because the raw data are hard to
obtain and there is a lack of statistical methods and software for
processing and interpreting the data.

This assignment makes use of data from a personal activity monitoring
device. This device collects data at 5 minute intervals through out the
day. The data consists of two months of data from an anonymous
individual collected during the months of October and November, 2012
and include the number of steps taken in 5 minute intervals each day.

## Data

The data for this assignment can be downloaded from the course web
site:

* Dataset: [Activity monitoring data](https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip) [52K]



The dataset is stored in a comma-separated-value (CSV) file and there
are a total of 17,568 observations in this
dataset.

<br><br>

## Loading and preprocessing the data

```r
# set working directory
setwd("~/Documents/workspace/Git_Repositories/Coursera Data Science/datasciencecoursera Projects/08 Practical Machine Learning Project")

# load training dataset
pml_training <- read_csv("~/Documents/workspace/Git_Repositories/Coursera Data Science/datasciencecoursera Projects/08 Practical Machine Learning Project/Data/pml-training.csv")
```

```
## Warning: Missing column names filled in: 'X1' [1]
```

```
## Parsed with column specification:
## cols(
##   .default = col_double(),
##   user_name = col_character(),
##   cvtd_timestamp = col_character(),
##   new_window = col_character(),
##   kurtosis_roll_belt = col_character(),
##   kurtosis_picth_belt = col_character(),
##   kurtosis_yaw_belt = col_character(),
##   skewness_roll_belt = col_character(),
##   skewness_roll_belt.1 = col_character(),
##   skewness_yaw_belt = col_character(),
##   max_yaw_belt = col_character(),
##   min_yaw_belt = col_character(),
##   amplitude_yaw_belt = col_character(),
##   kurtosis_picth_arm = col_character(),
##   kurtosis_yaw_arm = col_character(),
##   skewness_pitch_arm = col_character(),
##   skewness_yaw_arm = col_character(),
##   kurtosis_yaw_dumbbell = col_character(),
##   skewness_yaw_dumbbell = col_character(),
##   kurtosis_roll_forearm = col_character(),
##   kurtosis_picth_forearm = col_character()
##   # ... with 8 more columns
## )
```

```
## See spec(...) for full column specifications.
```

```
## Warning: 182 parsing failures.
##  row               col expected  actual                                                                                                                                                    file
## 2231 kurtosis_roll_arm a double #DIV/0! '~/Documents/workspace/Git_Repositories/Coursera Data Science/datasciencecoursera Projects/08 Practical Machine Learning Project/Data/pml-training.csv'
## 2231 skewness_roll_arm a double #DIV/0! '~/Documents/workspace/Git_Repositories/Coursera Data Science/datasciencecoursera Projects/08 Practical Machine Learning Project/Data/pml-training.csv'
## 2255 kurtosis_roll_arm a double #DIV/0! '~/Documents/workspace/Git_Repositories/Coursera Data Science/datasciencecoursera Projects/08 Practical Machine Learning Project/Data/pml-training.csv'
## 2255 skewness_roll_arm a double #DIV/0! '~/Documents/workspace/Git_Repositories/Coursera Data Science/datasciencecoursera Projects/08 Practical Machine Learning Project/Data/pml-training.csv'
## 2282 kurtosis_roll_arm a double #DIV/0! '~/Documents/workspace/Git_Repositories/Coursera Data Science/datasciencecoursera Projects/08 Practical Machine Learning Project/Data/pml-training.csv'
## .... ................. ........ ....... .......................................................................................................................................................
## See problems(...) for more details.
```
As can be seen below, the data has been correctedly loaded into the data frame **activity**:

```r
str(pml_training)
```

```
## tibble [19,622 × 160] (S3: spec_tbl_df/tbl_df/tbl/data.frame)
##  $ X1                      : num [1:19622] 1 2 3 4 5 6 7 8 9 10 ...
##  $ user_name               : chr [1:19622] "carlitos" "carlitos" "carlitos" "carlitos" ...
##  $ raw_timestamp_part_1    : num [1:19622] 1323084231 1323084231 1323084231 1323084232 1323084232 ...
##  $ raw_timestamp_part_2    : num [1:19622] 788290 808298 820366 120339 196328 ...
##  $ cvtd_timestamp          : chr [1:19622] "05/12/2011 11:23" "05/12/2011 11:23" "05/12/2011 11:23" "05/12/2011 11:23" ...
##  $ new_window              : chr [1:19622] "no" "no" "no" "no" ...
##  $ num_window              : num [1:19622] 11 11 11 12 12 12 12 12 12 12 ...
##  $ roll_belt               : num [1:19622] 1.41 1.41 1.42 1.48 1.48 1.45 1.42 1.42 1.43 1.45 ...
##  $ pitch_belt              : num [1:19622] 8.07 8.07 8.07 8.05 8.07 8.06 8.09 8.13 8.16 8.17 ...
##  $ yaw_belt                : num [1:19622] -94.4 -94.4 -94.4 -94.4 -94.4 -94.4 -94.4 -94.4 -94.4 -94.4 ...
##  $ total_accel_belt        : num [1:19622] 3 3 3 3 3 3 3 3 3 3 ...
##  $ kurtosis_roll_belt      : chr [1:19622] NA NA NA NA ...
##  $ kurtosis_picth_belt     : chr [1:19622] NA NA NA NA ...
##  $ kurtosis_yaw_belt       : chr [1:19622] NA NA NA NA ...
##  $ skewness_roll_belt      : chr [1:19622] NA NA NA NA ...
##  $ skewness_roll_belt.1    : chr [1:19622] NA NA NA NA ...
##  $ skewness_yaw_belt       : chr [1:19622] NA NA NA NA ...
##  $ max_roll_belt           : num [1:19622] NA NA NA NA NA NA NA NA NA NA ...
##  $ max_picth_belt          : num [1:19622] NA NA NA NA NA NA NA NA NA NA ...
##  $ max_yaw_belt            : chr [1:19622] NA NA NA NA ...
##  $ min_roll_belt           : num [1:19622] NA NA NA NA NA NA NA NA NA NA ...
##  $ min_pitch_belt          : num [1:19622] NA NA NA NA NA NA NA NA NA NA ...
##  $ min_yaw_belt            : chr [1:19622] NA NA NA NA ...
##  $ amplitude_roll_belt     : num [1:19622] NA NA NA NA NA NA NA NA NA NA ...
##  $ amplitude_pitch_belt    : num [1:19622] NA NA NA NA NA NA NA NA NA NA ...
##  $ amplitude_yaw_belt      : chr [1:19622] NA NA NA NA ...
##  $ var_total_accel_belt    : num [1:19622] NA NA NA NA NA NA NA NA NA NA ...
##  $ avg_roll_belt           : num [1:19622] NA NA NA NA NA NA NA NA NA NA ...
##  $ stddev_roll_belt        : num [1:19622] NA NA NA NA NA NA NA NA NA NA ...
##  $ var_roll_belt           : num [1:19622] NA NA NA NA NA NA NA NA NA NA ...
##  $ avg_pitch_belt          : num [1:19622] NA NA NA NA NA NA NA NA NA NA ...
##  $ stddev_pitch_belt       : num [1:19622] NA NA NA NA NA NA NA NA NA NA ...
##  $ var_pitch_belt          : num [1:19622] NA NA NA NA NA NA NA NA NA NA ...
##  $ avg_yaw_belt            : num [1:19622] NA NA NA NA NA NA NA NA NA NA ...
##  $ stddev_yaw_belt         : num [1:19622] NA NA NA NA NA NA NA NA NA NA ...
##  $ var_yaw_belt            : num [1:19622] NA NA NA NA NA NA NA NA NA NA ...
##  $ gyros_belt_x            : num [1:19622] 0 0.02 0 0.02 0.02 0.02 0.02 0.02 0.02 0.03 ...
##  $ gyros_belt_y            : num [1:19622] 0 0 0 0 0.02 0 0 0 0 0 ...
##  $ gyros_belt_z            : num [1:19622] -0.02 -0.02 -0.02 -0.03 -0.02 -0.02 -0.02 -0.02 -0.02 0 ...
##  $ accel_belt_x            : num [1:19622] -21 -22 -20 -22 -21 -21 -22 -22 -20 -21 ...
##  $ accel_belt_y            : num [1:19622] 4 4 5 3 2 4 3 4 2 4 ...
##  $ accel_belt_z            : num [1:19622] 22 22 23 21 24 21 21 21 24 22 ...
##  $ magnet_belt_x           : num [1:19622] -3 -7 -2 -6 -6 0 -4 -2 1 -3 ...
##  $ magnet_belt_y           : num [1:19622] 599 608 600 604 600 603 599 603 602 609 ...
##  $ magnet_belt_z           : num [1:19622] -313 -311 -305 -310 -302 -312 -311 -313 -312 -308 ...
##  $ roll_arm                : num [1:19622] -128 -128 -128 -128 -128 -128 -128 -128 -128 -128 ...
##  $ pitch_arm               : num [1:19622] 22.5 22.5 22.5 22.1 22.1 22 21.9 21.8 21.7 21.6 ...
##  $ yaw_arm                 : num [1:19622] -161 -161 -161 -161 -161 -161 -161 -161 -161 -161 ...
##  $ total_accel_arm         : num [1:19622] 34 34 34 34 34 34 34 34 34 34 ...
##  $ var_accel_arm           : num [1:19622] NA NA NA NA NA NA NA NA NA NA ...
##  $ avg_roll_arm            : num [1:19622] NA NA NA NA NA NA NA NA NA NA ...
##  $ stddev_roll_arm         : num [1:19622] NA NA NA NA NA NA NA NA NA NA ...
##  $ var_roll_arm            : num [1:19622] NA NA NA NA NA NA NA NA NA NA ...
##  $ avg_pitch_arm           : num [1:19622] NA NA NA NA NA NA NA NA NA NA ...
##  $ stddev_pitch_arm        : num [1:19622] NA NA NA NA NA NA NA NA NA NA ...
##  $ var_pitch_arm           : num [1:19622] NA NA NA NA NA NA NA NA NA NA ...
##  $ avg_yaw_arm             : num [1:19622] NA NA NA NA NA NA NA NA NA NA ...
##  $ stddev_yaw_arm          : num [1:19622] NA NA NA NA NA NA NA NA NA NA ...
##  $ var_yaw_arm             : num [1:19622] NA NA NA NA NA NA NA NA NA NA ...
##  $ gyros_arm_x             : num [1:19622] 0 0.02 0.02 0.02 0 0.02 0 0.02 0.02 0.02 ...
##  $ gyros_arm_y             : num [1:19622] 0 -0.02 -0.02 -0.03 -0.03 -0.03 -0.03 -0.02 -0.03 -0.03 ...
##  $ gyros_arm_z             : num [1:19622] -0.02 -0.02 -0.02 0.02 0 0 0 0 -0.02 -0.02 ...
##  $ accel_arm_x             : num [1:19622] -288 -290 -289 -289 -289 -289 -289 -289 -288 -288 ...
##  $ accel_arm_y             : num [1:19622] 109 110 110 111 111 111 111 111 109 110 ...
##  $ accel_arm_z             : num [1:19622] -123 -125 -126 -123 -123 -122 -125 -124 -122 -124 ...
##  $ magnet_arm_x            : num [1:19622] -368 -369 -368 -372 -374 -369 -373 -372 -369 -376 ...
##  $ magnet_arm_y            : num [1:19622] 337 337 344 344 337 342 336 338 341 334 ...
##  $ magnet_arm_z            : num [1:19622] 516 513 513 512 506 513 509 510 518 516 ...
##  $ kurtosis_roll_arm       : num [1:19622] NA NA NA NA NA NA NA NA NA NA ...
##  $ kurtosis_picth_arm      : chr [1:19622] NA NA NA NA ...
##  $ kurtosis_yaw_arm        : chr [1:19622] NA NA NA NA ...
##  $ skewness_roll_arm       : num [1:19622] NA NA NA NA NA NA NA NA NA NA ...
##  $ skewness_pitch_arm      : chr [1:19622] NA NA NA NA ...
##  $ skewness_yaw_arm        : chr [1:19622] NA NA NA NA ...
##  $ max_roll_arm            : num [1:19622] NA NA NA NA NA NA NA NA NA NA ...
##  $ max_picth_arm           : num [1:19622] NA NA NA NA NA NA NA NA NA NA ...
##  $ max_yaw_arm             : num [1:19622] NA NA NA NA NA NA NA NA NA NA ...
##  $ min_roll_arm            : num [1:19622] NA NA NA NA NA NA NA NA NA NA ...
##  $ min_pitch_arm           : num [1:19622] NA NA NA NA NA NA NA NA NA NA ...
##  $ min_yaw_arm             : num [1:19622] NA NA NA NA NA NA NA NA NA NA ...
##  $ amplitude_roll_arm      : num [1:19622] NA NA NA NA NA NA NA NA NA NA ...
##  $ amplitude_pitch_arm     : num [1:19622] NA NA NA NA NA NA NA NA NA NA ...
##  $ amplitude_yaw_arm       : num [1:19622] NA NA NA NA NA NA NA NA NA NA ...
##  $ roll_dumbbell           : num [1:19622] 13.1 13.1 12.9 13.4 13.4 ...
##  $ pitch_dumbbell          : num [1:19622] -70.5 -70.6 -70.3 -70.4 -70.4 ...
##  $ yaw_dumbbell            : num [1:19622] -84.9 -84.7 -85.1 -84.9 -84.9 ...
##  $ kurtosis_roll_dumbbell  : num [1:19622] NA NA NA NA NA NA NA NA NA NA ...
##  $ kurtosis_picth_dumbbell : num [1:19622] NA NA NA NA NA NA NA NA NA NA ...
##  $ kurtosis_yaw_dumbbell   : chr [1:19622] NA NA NA NA ...
##  $ skewness_roll_dumbbell  : num [1:19622] NA NA NA NA NA NA NA NA NA NA ...
##  $ skewness_pitch_dumbbell : num [1:19622] NA NA NA NA NA NA NA NA NA NA ...
##  $ skewness_yaw_dumbbell   : chr [1:19622] NA NA NA NA ...
##  $ max_roll_dumbbell       : num [1:19622] NA NA NA NA NA NA NA NA NA NA ...
##  $ max_picth_dumbbell      : num [1:19622] NA NA NA NA NA NA NA NA NA NA ...
##  $ max_yaw_dumbbell        : num [1:19622] NA NA NA NA NA NA NA NA NA NA ...
##  $ min_roll_dumbbell       : num [1:19622] NA NA NA NA NA NA NA NA NA NA ...
##  $ min_pitch_dumbbell      : num [1:19622] NA NA NA NA NA NA NA NA NA NA ...
##  $ min_yaw_dumbbell        : num [1:19622] NA NA NA NA NA NA NA NA NA NA ...
##  $ amplitude_roll_dumbbell : num [1:19622] NA NA NA NA NA NA NA NA NA NA ...
##   [list output truncated]
##  - attr(*, "problems")= tibble [182 × 5] (S3: tbl_df/tbl/data.frame)
##   ..$ row     : int [1:182] 2231 2231 2255 2255 2282 2282 2314 2314 2422 2422 ...
##   ..$ col     : chr [1:182] "kurtosis_roll_arm" "skewness_roll_arm" "kurtosis_roll_arm" "skewness_roll_arm" ...
##   ..$ expected: chr [1:182] "a double" "a double" "a double" "a double" ...
##   ..$ actual  : chr [1:182] "#DIV/0!" "#DIV/0!" "#DIV/0!" "#DIV/0!" ...
##   ..$ file    : chr [1:182] "'~/Documents/workspace/Git_Repositories/Coursera Data Science/datasciencecoursera Projects/08 Practical Machine"| __truncated__ "'~/Documents/workspace/Git_Repositories/Coursera Data Science/datasciencecoursera Projects/08 Practical Machine"| __truncated__ "'~/Documents/workspace/Git_Repositories/Coursera Data Science/datasciencecoursera Projects/08 Practical Machine"| __truncated__ "'~/Documents/workspace/Git_Repositories/Coursera Data Science/datasciencecoursera Projects/08 Practical Machine"| __truncated__ ...
##  - attr(*, "spec")=
##   .. cols(
##   ..   X1 = col_double(),
##   ..   user_name = col_character(),
##   ..   raw_timestamp_part_1 = col_double(),
##   ..   raw_timestamp_part_2 = col_double(),
##   ..   cvtd_timestamp = col_character(),
##   ..   new_window = col_character(),
##   ..   num_window = col_double(),
##   ..   roll_belt = col_double(),
##   ..   pitch_belt = col_double(),
##   ..   yaw_belt = col_double(),
##   ..   total_accel_belt = col_double(),
##   ..   kurtosis_roll_belt = col_character(),
##   ..   kurtosis_picth_belt = col_character(),
##   ..   kurtosis_yaw_belt = col_character(),
##   ..   skewness_roll_belt = col_character(),
##   ..   skewness_roll_belt.1 = col_character(),
##   ..   skewness_yaw_belt = col_character(),
##   ..   max_roll_belt = col_double(),
##   ..   max_picth_belt = col_double(),
##   ..   max_yaw_belt = col_character(),
##   ..   min_roll_belt = col_double(),
##   ..   min_pitch_belt = col_double(),
##   ..   min_yaw_belt = col_character(),
##   ..   amplitude_roll_belt = col_double(),
##   ..   amplitude_pitch_belt = col_double(),
##   ..   amplitude_yaw_belt = col_character(),
##   ..   var_total_accel_belt = col_double(),
##   ..   avg_roll_belt = col_double(),
##   ..   stddev_roll_belt = col_double(),
##   ..   var_roll_belt = col_double(),
##   ..   avg_pitch_belt = col_double(),
##   ..   stddev_pitch_belt = col_double(),
##   ..   var_pitch_belt = col_double(),
##   ..   avg_yaw_belt = col_double(),
##   ..   stddev_yaw_belt = col_double(),
##   ..   var_yaw_belt = col_double(),
##   ..   gyros_belt_x = col_double(),
##   ..   gyros_belt_y = col_double(),
##   ..   gyros_belt_z = col_double(),
##   ..   accel_belt_x = col_double(),
##   ..   accel_belt_y = col_double(),
##   ..   accel_belt_z = col_double(),
##   ..   magnet_belt_x = col_double(),
##   ..   magnet_belt_y = col_double(),
##   ..   magnet_belt_z = col_double(),
##   ..   roll_arm = col_double(),
##   ..   pitch_arm = col_double(),
##   ..   yaw_arm = col_double(),
##   ..   total_accel_arm = col_double(),
##   ..   var_accel_arm = col_double(),
##   ..   avg_roll_arm = col_double(),
##   ..   stddev_roll_arm = col_double(),
##   ..   var_roll_arm = col_double(),
##   ..   avg_pitch_arm = col_double(),
##   ..   stddev_pitch_arm = col_double(),
##   ..   var_pitch_arm = col_double(),
##   ..   avg_yaw_arm = col_double(),
##   ..   stddev_yaw_arm = col_double(),
##   ..   var_yaw_arm = col_double(),
##   ..   gyros_arm_x = col_double(),
##   ..   gyros_arm_y = col_double(),
##   ..   gyros_arm_z = col_double(),
##   ..   accel_arm_x = col_double(),
##   ..   accel_arm_y = col_double(),
##   ..   accel_arm_z = col_double(),
##   ..   magnet_arm_x = col_double(),
##   ..   magnet_arm_y = col_double(),
##   ..   magnet_arm_z = col_double(),
##   ..   kurtosis_roll_arm = col_double(),
##   ..   kurtosis_picth_arm = col_character(),
##   ..   kurtosis_yaw_arm = col_character(),
##   ..   skewness_roll_arm = col_double(),
##   ..   skewness_pitch_arm = col_character(),
##   ..   skewness_yaw_arm = col_character(),
##   ..   max_roll_arm = col_double(),
##   ..   max_picth_arm = col_double(),
##   ..   max_yaw_arm = col_double(),
##   ..   min_roll_arm = col_double(),
##   ..   min_pitch_arm = col_double(),
##   ..   min_yaw_arm = col_double(),
##   ..   amplitude_roll_arm = col_double(),
##   ..   amplitude_pitch_arm = col_double(),
##   ..   amplitude_yaw_arm = col_double(),
##   ..   roll_dumbbell = col_double(),
##   ..   pitch_dumbbell = col_double(),
##   ..   yaw_dumbbell = col_double(),
##   ..   kurtosis_roll_dumbbell = col_double(),
##   ..   kurtosis_picth_dumbbell = col_double(),
##   ..   kurtosis_yaw_dumbbell = col_character(),
##   ..   skewness_roll_dumbbell = col_double(),
##   ..   skewness_pitch_dumbbell = col_double(),
##   ..   skewness_yaw_dumbbell = col_character(),
##   ..   max_roll_dumbbell = col_double(),
##   ..   max_picth_dumbbell = col_double(),
##   ..   max_yaw_dumbbell = col_double(),
##   ..   min_roll_dumbbell = col_double(),
##   ..   min_pitch_dumbbell = col_double(),
##   ..   min_yaw_dumbbell = col_double(),
##   ..   amplitude_roll_dumbbell = col_double(),
##   ..   amplitude_pitch_dumbbell = col_double(),
##   ..   amplitude_yaw_dumbbell = col_double(),
##   ..   total_accel_dumbbell = col_double(),
##   ..   var_accel_dumbbell = col_double(),
##   ..   avg_roll_dumbbell = col_double(),
##   ..   stddev_roll_dumbbell = col_double(),
##   ..   var_roll_dumbbell = col_double(),
##   ..   avg_pitch_dumbbell = col_double(),
##   ..   stddev_pitch_dumbbell = col_double(),
##   ..   var_pitch_dumbbell = col_double(),
##   ..   avg_yaw_dumbbell = col_double(),
##   ..   stddev_yaw_dumbbell = col_double(),
##   ..   var_yaw_dumbbell = col_double(),
##   ..   gyros_dumbbell_x = col_double(),
##   ..   gyros_dumbbell_y = col_double(),
##   ..   gyros_dumbbell_z = col_double(),
##   ..   accel_dumbbell_x = col_double(),
##   ..   accel_dumbbell_y = col_double(),
##   ..   accel_dumbbell_z = col_double(),
##   ..   magnet_dumbbell_x = col_double(),
##   ..   magnet_dumbbell_y = col_double(),
##   ..   magnet_dumbbell_z = col_double(),
##   ..   roll_forearm = col_double(),
##   ..   pitch_forearm = col_double(),
##   ..   yaw_forearm = col_double(),
##   ..   kurtosis_roll_forearm = col_character(),
##   ..   kurtosis_picth_forearm = col_character(),
##   ..   kurtosis_yaw_forearm = col_character(),
##   ..   skewness_roll_forearm = col_character(),
##   ..   skewness_pitch_forearm = col_character(),
##   ..   skewness_yaw_forearm = col_character(),
##   ..   max_roll_forearm = col_double(),
##   ..   max_picth_forearm = col_double(),
##   ..   max_yaw_forearm = col_character(),
##   ..   min_roll_forearm = col_double(),
##   ..   min_pitch_forearm = col_double(),
##   ..   min_yaw_forearm = col_character(),
##   ..   amplitude_roll_forearm = col_double(),
##   ..   amplitude_pitch_forearm = col_double(),
##   ..   amplitude_yaw_forearm = col_character(),
##   ..   total_accel_forearm = col_double(),
##   ..   var_accel_forearm = col_double(),
##   ..   avg_roll_forearm = col_double(),
##   ..   stddev_roll_forearm = col_double(),
##   ..   var_roll_forearm = col_double(),
##   ..   avg_pitch_forearm = col_double(),
##   ..   stddev_pitch_forearm = col_double(),
##   ..   var_pitch_forearm = col_double(),
##   ..   avg_yaw_forearm = col_double(),
##   ..   stddev_yaw_forearm = col_double(),
##   ..   var_yaw_forearm = col_double(),
##   ..   gyros_forearm_x = col_double(),
##   ..   gyros_forearm_y = col_double(),
##   ..   gyros_forearm_z = col_double(),
##   ..   accel_forearm_x = col_double(),
##   ..   accel_forearm_y = col_double(),
##   ..   accel_forearm_z = col_double(),
##   ..   magnet_forearm_x = col_double(),
##   ..   magnet_forearm_y = col_double(),
##   ..   magnet_forearm_z = col_double(),
##   ..   classe = col_character()
##   .. )
```


<br><br>

