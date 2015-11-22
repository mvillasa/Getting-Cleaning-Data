#%%%%%%%%%%%%
#% Part 1  %%
#%%%%%%%%%%%%

# I dowload all the files and put them in the directory

# Go to each directory and read the files that you need,
#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#%% The user MUST change the working directory to the directory where   %%
#%% the train and test subfolders are available                         %%
#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

x_ts<-read.table("./test/X_test.txt")
y_ts<-read.table("./test/y_test.txt")
sub_ts<-read.table("./test/subject_test.txt")


sub_tr<-read.table("./train/subject_train.txt")
x_tr<-read.table("./train/X_train.txt")
y_tr<-read.table("./train/y_train.txt")

# Assemble them in a bigger matrix
#  first the training and then the test data

trainData<-cbind(x_tr,y_tr,sub_tr)
testData<-cbind(x_ts,y_ts,sub_ts)

# Then you patch them one after the other
#  but you add a column at the end that says if the data
#  point belongs to the training (1) or test (2) set

completeData<-rbind(trainData,testData)
f<-rep(1:2,c(nrow(y_tr),nrow(y_ts)))
completeData<-cbind(completeData,f)

#%%%%%%%%%%%%%
#%% Part 2  %%
#%%%%%%%%%%%%%

# After looking at the feature_info.txt file you notice that there are 33
#  measurements for the mean and 33 for the std, they are located on columns
#  1-3, 41-43, 81-83, 121-123, 161-163, 201, 214, 227, 240, 253, 266-268, 345-347, 424-426, 503, 516, 529, 542
#  for measurements regarding the mean of the 33 signals,  and are located on columns
#  4-6, 44-46, 84-86, 124-126, 164-166, 202, 215, 228, 241, 254, 269-271, 348-350, 427-429, 504, 517, 530, 543
#  for measurements regarding the std of the 33 signals.  These values were inferred from the names in the 
#  feature_info.txt file.

# establish the columns to extract with the requested data. There are 66 columns of this type in total.
cols<-c(1:6,41:46,81:86, 121:126, 161:166, 201:202, 214:215, 227:228, 240:241, 253:254, 266:271, 345:350, 424:429)
cols<-c(cols, 503:504, 516:517, 529:530, 542:543)

# add the 3 columns at the end for activity type, subject index, and data type
cols<-c(cols, 562:564)

# make a new data set with only that.
semiTidyData<-completeData[,cols]

#%%%%%%%%%%%%%
#%% Part 3  %%
#%%%%%%%%%%%%%


# on column 67 of semiTidyData we have the activity type coded as a number from 1-6. They will be labeled according to:
# 1 Walking
# 2 Walking_up
# 3 Walking_down
# 4 Sitting
# 5 Standing
# 6 Laying

aux<-semiTidyData
aux2<-semiTidyData

I=which(aux2[,67]==1)
aux[,67]<-replace(aux[,67],I,"Walking")

I=which(aux2[,67]==2)
aux[,67]<-replace(aux[,67],I,"Walking_up")

I=which(aux2[,67]==3)
aux[,67]<-replace(aux[,67],I,"Walking_down")

I=which(aux2[,67]==4)
aux[,67]<-replace(aux[,67],I,"Sitting")

I=which(aux2[,67]==5)
aux[,67]<-replace(aux[,67],I,"Standing")

I=which(aux2[,67]==6)
aux[,67]<-replace(aux[,67],I,"Laying")

# We will also rename the data type column (69) as "train" and "test".

I=which(aux2[,69]==1)
aux[,69]<-replace(aux[,69],I,"train")

I=which(aux2[,69]==2)
aux[,69]<-replace(aux[,69],I,"test")

tidyData<-aux;

#%%%%%%%%%%%%%
#%% Part 4  %%
#%%%%%%%%%%%%%

# For name labelling, we have used the initial letters form the description, so for example:
#  "tbodyGyroJerkX-mean" is labelled as tBGyJ_x_m and so on.

CC<-c("tBA_x_m","tBA_y_m","tBA_z_m", "tBA_x_std","tBA_y_std","tBA_z_std","tGrA_x_m","tGrA_y_m","tGrA_z_m","tGrA_x_std")
CC<-c(CC,"tGrA_y_std","tGrA_z_std")
CC<-c(CC,"tBAJ_x_m","tBAJ_y_m","tBAJ_z_m","tBAJ_x_std","tBAJ_y_std","tBAJ_z_std","tBGy_x_m","tBGy_y_m","tBGy_z_m")
CC<-c(CC,"tBGy_x_std","tBGy_y_std","tBGy_z_std")
CC<-c(CC,"tBGyJ_x_m","tBGyJ_y_m","tBGyJ_z_m","tBGyJ_x_std","tBGyJ_y_std","tBGyJ_z_std","tBAM_m","tBAM_std","tGrAM_m")
CC<-c(CC,"tGrAM_std","tBAJM_m","tBAJM_std")
CC<-c(CC,"tBGyM_m","tBGyM_std", "tBGyJM_m","tBGyJM_std","fBA_x_m","fBA_y_m","fBA_z_m","fBA_x_std","fBA_y_std","fBA_z_std")
CC<-c(CC,"fBAJ_x_m","fBAJ_y_m","fBAJ_z_m")
CC<-c(CC,"fBAJ_x_std","fBAJ_y_std","fBAJ_z_std","fBGy_x_m","fBGy_y_m","fBGy_z_m","fBGy_x_std","fBGy_y_std","fBGy_z_std")
CC<-c(CC,"fBAM_m","fBAM_std","fBBAJM_m","fBBAJM_std")
CC<-c(CC,"fBBGyM_m","fBBGyM_std","fBBGyJM_m","fBBGyJM_std","Act_type","Subject","Data_type")

for (i in 1:length(CC)) {names(tidyData)[i]<-CC[i]}

#%%%%%%%%%%%%%
#%% Part 5  %%
#%%%%%%%%%%%%%

tidyData2<-tidyData
tidyData2<-tidyData2[,-69]

#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
#% the package dplyr MUST be loaded for the following to work %
#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
by_subj_Act<-group_by(tidyData2,Subject,Act_type)
D=summarise_each(by_subj_Act,funs(mean))
write.table(D,file="TidyData.txt",row.name=FALSE)
