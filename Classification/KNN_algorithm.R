#Read data
social_data <- read.csv("E:/R Programming/Datacamp tutorials/Datacamp_R_Programming/Classification/Classification_with_dataset/KNN_algo/Social_Network_Ads.csv")

social_data

#summary of social data
summary(social_data)


# Check the dimensions
dim(social_data)

# View the column names
names(social_data)

# View the structure of the data
str(social_data)

# Load dplyr package
library(dplyr)

# Look at the structure using dplyr's glimpse()
glimpse(social_data)

#loading library class
library(class)

#table function to check the number of purchased and non purchased
table(social_data$Purchased)

social_data$Purchased <- factor(x = train_data$Purchased,labels = c("Yes","No"), levels = c(1,0))
#test train split using manual method
split <-round(nrow(social_data ) * 0.80)

train_data <- social_data[1:split,]
test_data <- social_data[(split+1):nrow(social_data),]

#Knn algorithm
#prob used to getting proportion of votes for winning class
model <- knn(train = train_data[,3:4], test = test_data[,3:4], cl = train_data$Purchased  , k=3, prob = TRUE)

#confusion matrix using table function
table(model,test_data$Purchased) 


plot(model)

library(caret)

# Convert to factor: p_class
p_class <- factor(x=test_data$Purchased,labels = c("Yes","No"), levels = c(1,0))
model_value <- factor(x=model,labels = c("Yes","No"), levels = c(1,0))

confusionMatrix(model_value, p_class)

library(caTools)
colAUC(as.numeric(model), p_class, plotROC = TRUE)
