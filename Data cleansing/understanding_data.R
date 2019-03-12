#Data Cleansing
#Step 1:Understanding Data
#read data 
lunch <- mtcars

#Viewing its class
class(lunch)

#Dimension of the data
dim(lunch)

#View the column names
names(lunch)

#Structure of the data: provides compact summary of its internal structures (Rows are obsevations and columns are variables)
str(lunch)

#load dplyr
install.packages("dplyr")
library(dplyr)

#similar to str, dplyr has a function callled glimpse
glimpse(lunch)

#summary of distribution of each column
summary(lunch)

#Exploring the data
#Display first 15 rows
head(lunch, n=15)

#Displays last 15 rows
tail(lunch, n=15)

#Visualize the data
hist(lunch$mpg)

#Step 3: Tidying data
install.packages("tidyr")
library("tidyr")

#Expands the columns into rows
data_long <-gather(lunch, vs, sm)

#shrink rows to columns
spread(data_long,vs, sm)

#Separating a column having two data
separate(lunch, colName, c("new column name","new column name"), sep ="-")

#Unite the two columns
unite(lunch, new_column, column1_join, column2_join , sep="-") #default is _

#Common symptoms of messy data





