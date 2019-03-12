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
# Specify a null model with no predictors
null_model <- glm(Purchased ~ 1, data = train_data, family = "binomial")

# Specify the full model using all of the potential predictors
full_model <- glm(Purchased ~ ., data = train_data, family = "binomial")

# Use a forward stepwise algorithm to build a parsimonious model
step_model <- step(null_model, scope = list(lower = null_model, upper = full_model), direction = "forward")

summary(step_model)

Prob_y_pred <- predict(step_model,type="response", newdata = test_data[-5])

Prob_y_pred<-ifelse(Prob_y_pred<0.5,0,1)

#confusion matrix using table function
table(Prob_y_pred,test_data$Purchased) 

plot(model)

library(caret)

# Convert to factor: p_class
p_class <- factor(x=test_data$Purchased,labels = c("Yes","No"), levels = c(1,0))
model <- factor(x=Prob_y_pred,labels = c("Yes","No"), levels = c(1,0))

confusionMatrix(model, p_class)

library(caTools)
colAUC(Prob_y_pred, p_class, plotROC = TRUE)

