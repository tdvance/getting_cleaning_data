library(dplyr); #needed for summarise_each

run_analysis = function()){
  
  
  #Load the activity lables and features
  activities = read.table("HAR/activity_labels.txt", col.names = c("label", "description"));
  features = read.table("HAR/features.txt", col.names = c("label", "description"));
  
  #load the test and training data for measured and computed features
  xtest = read.table("HAR/test/X_test.txt", col.names = features$description)
  xtrain = read.table("HAR/train/X_train.txt", col.names = features$description)
  
  #load the test and training data for observed activity labels
  ytest = read.table("HAR/test/y_test.txt", col.names = "label");
  ytrain = read.table("HAR/train/y_train.txt", col.names = "label");
  
  #Combine the test and training data
  x = rbind(xtest, xtrain)
  y = rbind(ytest, ytrain)
  
  #Find the indices for features to compute means and standard deviations
  meanFeatures = grep("mean[(][)]", features$description, ignore.case=TRUE);
  stdFeatures = grep("std[(][)]", features$description, ignore.case=TRUE);
  
  #combine into one long index list
  msFeatures = c(meanFeatures, stdFeatures);
  
  #select just the mean and standard deviation features from the feature table
  xms = x[, msFeatures];
  
  #convert observed activity labels to human-readible descriptions
  y$label = activities$description[as.integer(y$label)];
  
  #combine the features and label descriptions into  the data set (step 4)
  xtable = cbind(x, label=y$label);
  
  #create the tidy data set having only means of data grouped by activity label
  xtidy = xtable %>% group_by(label) %>% summarise_each(funs(mean));
  
  #store the tidy data set as a text file
  #write.table(xtidy, file="xtidy.txt", row.names=FALSE);
  
  #return the tidy data frame
  xtidy
}
