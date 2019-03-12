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


#Naive Bayes
#prob used to getting proportion of votes for winning class
model <- naive_bayes(Purchased~Age + EstimatedSalary, data = train_data, laplace = 1)

y_pred <- predict(model, test_data[-5],type = "prob")


plot(y_pred)

library(caret)

# Convert to factor: p_class
p_class <- factor(x=test_data[5],labels = c("Yes","No"), levels = c(1,0))
pred_value <- factor(x=y_pred,labels = c("Yes","No"), levels = c(1,0))

confusionMatrix(model_value, p_class)

library(caTools)
colAUC(as.numeric(model), p_class, plotROC = TRUE)
