#Read data
drug_data <- read.csv("E:/R Programming/Datacamp tutorials/Datacamp_R_Programming/Classification/Classification_with_dataset/Naive Bayes/drug200.csv")

drug_data

#summary of social data
summary(drug_data)


# Check the dimensions
dim(drug_data)

# View the column names
names(drug_data)

# View the structure of the data
str(drug_data)

# Load dplyr package
library(dplyr)

# Look at the structure using dplyr's glimpse()
glimpse(drug_data)

#loading library class
library(rpart)

#table function to check the number of purchased and non purchased
table(drug_data$Drug)

#FACTOR categorical variable
drug_data$Sex <- factor(x = drug_data$Sex, levels = c(0,1), labels = c("F","M"))
drug_data$BP <- factor(x = drug_data$BP, levels = c(0,1,2), labels = c("LOW","NORMAL","HIGH"))
drug_data$Cholesterol <- factor(x = drug_data$Cholesterol, levels = c(0,1), labels = c("NORMAL","HIGH"))

#test train split using manual method
split <-round(nrow(drug_data ) * 0.80)

train_data <- drug_data[1:split,]
test_data <- drug_data[(split+1):nrow(drug_data),]

#Fitting the model
#pre pruning strategy
drug_model <- rpart(Drug ~ . , data = train_data, method = "class", control = rpart.control(maxdepth = 10, minsplit = 10))

plotcp(drug_model)
#post pruning using elbow method
drug_model_post_prune <- rpart(Drug ~ . , data = train_data, method = "class", control = rpart.control(cp=.11))

# Make a prediction for someone with good credit
y_pred <-predict(drug_model, test_data[-6], type = "class")

library(rpart.plot)
rpart.plot(drug_model, fallen.leaves = TRUE)

table(test_data$Drug, y_pred)

confusionMatrix(test_data$Drug, y_pred)

