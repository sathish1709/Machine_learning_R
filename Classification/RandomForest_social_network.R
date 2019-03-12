#Read data
social_data <- read.csv("E:/R Programming/Datacamp tutorials/Datacamp_R_Programming/Classification/Classification_with_dataset/Naive Bayes/Social_Network_Ads.csv")

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
library(naivebayes)

#table function to check the number of purchased and non purchased
table(social_data$Purchased)

social_data$Purchased <- factor(x = social_data$Purchased, levels = c(0,1))

#test train split using manual method
split <-round(nrow(social_data ) * 0.80)

train_data <- social_data[1:split,]
test_data <- social_data[(split+1):nrow(social_data),]


#Fitting the model
library(randomForest)
model <- randomForest(Purchased ~ . , data = train_data, ntree = 10)

# Make a prediction for someone with good credit
y_pred <-predict(model, test_data[-5], type = "class")

table(test_data$Purchased, y_pred)

library(caret)
confusionMatrix(test_data$Purchased, y_pred)

