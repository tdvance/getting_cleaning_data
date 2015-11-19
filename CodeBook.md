The raw data needed is in six files:

- HAR/activity_labels.txt
  
  -- maps labels 1-6 found in the data to human-readible descriptions.  Columns are called "label" and "description".  There are 6 rows.
  
- HAR/features.txt

  -- maps labels 1-561 found in the data to descriptive feature names.  Columns are called "label" and "description".  There are 561 rows.

- HAR/test/X_test.txt

  -- The data set of features (test set).  Rows are individual measurements, and columns are features.

- HAR/train/X_train.txt

  -- The data set of features (training set).  Rows are individual measurements, and columns are features.

- HAR/test/y_test.txt

  -- The data set of observed labels (test set).  There is one column, the labels.  Rows are individual observations.

- HAR/train/y_train.txt

  -- The data set of observed labels (training set).  There is one column, the labels.  Rows are individual observations.
  
  First the script loads these files, using R's "read.table" command, into R variables. The default field separator of "white space" is used.  The first two files are used to name the columns of the latter four.  In particular, the activity_labels descriptions (its second column) name the sole column of the y test and training data.  The features descriptions (its second column) name the feature labels, in the same order, in the x test and training data.
  
  Next, the x test and x train tables are concatenated, the rows of the latter placed immediately after the rows of the former.  Likewise, the y test and y train tables are concatenated, with the rows of the latter after the rows of the former.  We do not wish to distinguish test and training data.  The x test and train tables become table x.  The y test and train tables become table y.
  
  Now, we are only interested in features that are means of standard deviations of measurements.  So, we compute the indices (labels) of the feature names (descriptions) that contain the string "mean()" and the string "std()".  These indices are used to select the columns of table x, first all the means, then all the standard deviations, but leaving the order as they occur in the original downloaded file.
  
  The y table is a column of labels that are currently integers 1 through 6 and we want human-readible descriptions, so the activities table is used to rename the entries in the column to the activity descriptions.
  
  The complete data set is then constructed by appending the columns of x to the columns of y, forming the variable xtable.
  
  The tidy data set is constructed from xtable by grouping the rows according to the value of the observed label (from the y table), thus into six groups of rows.  The means of each column of features (the xtable columns that came from the x table) in each group is computed and the tidy set now has only 6 rows, one for each observed label, each row having the means of the each of the features labeled with the same observed label.
  
  
  
  
