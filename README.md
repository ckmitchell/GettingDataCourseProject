#This README describes how the code works and what scripts were scripts used. 
The run_analysis.R code uses the Samsung Galaxy SII smartphone data from UCI found at <http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>

#First, the code merges multiple txt files into one dataset and cleans up the column headings

1. The code downloads and unzips the dataset using download.file() and unzip()

2. Then a filepath is set using file.path and the files are listed using list.file to make sure all the data is there

3. The x test and x train txt files are read using read.table 

4. The x files are merged into one dataset using rbind()

5. The features txt file is read using read.table

6. It is added to the merged data set using colnames()

7. All columns with mean() or std() are extracted from the dataset using grep

8. The column headings are cleaned up using gsub

9. The y test and y train txt files (the activity data) are read using read.table
 
10. The y files are merged using rbind()
 
11. A column called "ID" is created using colnames()
 
12. Activity labels are created by using read.table to read the activity_labels txt file
 
13. Columns for "ID" and "activity" are created using colnames()
 
14. Activity labels and activity data are joined by "ID" using the plyr package function join()
 
15. The activity data and labels are added to the merged dataset using cbind() and joined on "activity"
 
16. The subject txt files are read using read.table
 
17. The subject data is merged using rbind()

18. A "SubID" column is created using colnames()
 
19. The subject data is added to the merged dataset using cbind()


#Next, a new dataset that summarizes the merged dataset by subject and activty is created using dplyr

1. dplyr is installed and loaded using install.packages() and library(dplyr)

2. the dataset "tidy" is created by using the summarize_each funciton in the dplyer package to summarize each variable in the dataset by mean

3. the group_by function is used to group the dataset by subject and activity


#Finally, the new dataset is output into a txt file

1. The write.table function is used to write the tidy dataset into a txt file


