library(plyr)
library(dplyr)
library(data.table)
library(reshape2)

#Test Data
setwd('/Users/Mikey/Desktop/Getting & Cleaning Data/Course Project/UCI HAR Dataset/test')
  subject_test<-read.table('subject_test.txt')
  test_set<-read.table('X_test.txt')
  test_labels<-read.table('y_test.txt')
  test_dat<-data.frame(subject_test,test_labels,test_set)
  
#Train Data
  setwd('/Users/Mikey/Desktop/Getting & Cleaning Data/Course Project/UCI HAR Dataset/train')
  subject_train<-read.table('subject_train.txt')
  train_set<-read.table('X_train.txt')
  train_labels<-read.table('y_train.txt')
  train_dat<-data.frame(subject_train,train_labels,train_set)
  
#Combined - Create Combined Data Frame {No Meaningful Column Labels}
  combined_dat<-rbind(test_dat,train_dat)

#Identify Which Columns  
setwd('/Users/Mikey/Desktop/Getting & Cleaning Data/Course Project/UCI HAR Dataset')
  features<-read.table('features.txt')
  activity<-read.table('activity_labels.txt')
  indx_means_std<-grep('mean|std',features[,2])
  
  mean_std_dat<-combined_dat[,c(indx_means_std)]
  
  dat_col_names<-features[indx_means_std,2]
  dat_col_names<-gsub("\\()","",dat_col_names)
  dat_col_names<-sub('^t','TimeDomain_',dat_col_names)
  dat_col_names<-sub('^f','FrequencyDomain_',dat_col_names)
  dat_col_names<-gsub('-','_',dat_col_names)
  
  names(mean_std_dat)<-dat_col_names
  
  mean_std_dat<-mutate(mean_std_dat,subject=combined_dat[,1],activity_ID=combined_dat[,2])
  mean_std_dat<-mutate(mean_std_dat,activity=activity[activity_ID,2])
  
  #Remove Activity ID
  mean_std_dat<-mean_std_dat[,-81]
  
  #Calculate Means Using Subject & Activity as Groupings
  melted_data<- melt(mean_std_dat,id=c('subject','activity'))
  melted_data<-dcast(melted_data,subject+activity~variable,mean)
  
  output<-melted_data
  
  write.table(output,file='Mikhail_Lara_Project_Output.txt',row.name = FALSE)
