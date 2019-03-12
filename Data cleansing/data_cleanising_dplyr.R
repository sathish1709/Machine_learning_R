#Data cleansning using dplyr
# Load the dplyr package
install.packages("dplyr")
library(dplyr)
# Load the hflights package
install.packages("hflights")
library(hflights)

# Call both head() and summary() on hflights
head(hflights)
summary(hflights)

glimpse(hflights)
hflights <- tbl_df(hflights)

as.data.frame(hflights)

# Both the dplyr and hflights packages are loaded into workspace
lut <- c("AA" = "American", "AS" = "Alaska", "B6" = "JetBlue", "CO" = "Continental", 
         "DL" = "Delta", "OO" = "SkyWest", "UA" = "United", "US" = "US_Airways", 
         "WN" = "Southwest", "EV" = "Atlantic_Southeast", "F9" = "Frontier", 
         "FL" = "AirTran", "MQ" = "American_Eagle", "XE" = "ExpressJet", "YV" = "Mesa")

# Add the Carrier column to hflights
hflights$Carrier <-lut[hflights$UniqueCarrier]

# Glimpse at hflights
glimpse(hflights)

#Verbs in dplyr: slect, filter, arrange, mutate, summarise
#select and mutate are used in column level to select or add new columns to data set
#filter, arrange are used at row level for observations
#summarise for groups of observations


# hflights is pre-loaded as a tbl, together with the necessary libraries.

# Print out a tbl with the four columns of hflights related to delay
select(hflights, ActualElapsedTime, AirTime, ArrDelay, DepDelay)

# Print out the columns Origin up to Cancelled of hflights
select(hflights,14:19, -2)

# Answer to last question: be concise!
select(hflights,{1:21}, -{5:11})

# As usual, hflights is pre-loaded as a tbl, together with the necessary libraries.

# Print out a tbl containing just ArrDelay and DepDelay
select(hflights, 12:13, -19)

# Print out a tbl as described in the second instruction, using both helper functions and variable names
select(hflights,UniqueCarrier,starts_with("Cancel"),ends_with("Num"))
select(hflights,{7:21},-{10:18})

# Print out a tbl as described in the third instruction, using only helper functions.
select(hflights, ends_with("Time"),ends_with("Delay")) 

select(hflights, contains("Tim"), contains("Del"))

# both hflights and dplyr are available

# Finish select call so that ex1d matches ex1r
ex1r <- hflights[c("TaxiIn", "TaxiOut", "Distance")]
ex1d <- select(hflights, starts_with("Taxi"), Distance)

# Finish select call so that ex2d matches ex2r
ex2r <- hflights[c("Year", "Month", "DayOfWeek", "DepTime", "ArrTime")]
ex2d <- select(hflights,{1:6},-3)

# Finish select call so that ex3d matches ex3r
ex3r <- hflights[c("TailNum", "TaxiIn", "TaxiOut")]
ex3d <- select(hflights, starts_with("Tail"),starts_with("Taxi"))


#Mutate function
# hflights and dplyr are loaded and ready to serve you.

# Add the new variable ActualGroundTime to a copy of hflights and save the result as g1.
g1<-mutate(hflights, ActualGroundTime = ActualElapsedTime - AirTime )

# Add the new variable GroundTime to g1. Save the result as g2.
g2<-mutate(g1, GroundTime = TaxiIn + TaxiOut)
g1$ActualGroundTime
g2$GroundTime
# Add the new variable AverageSpeed to g2. Save the result as g3.
g3<-mutate(g2, AverageSpeed = 60 * Distance / AirTime)
g3

# hflights and dplyr are ready, are you?

# Add a second variable loss_ratio to the dataset: m1
m1 <- mutate(hflights, loss = ArrDelay - DepDelay, loss_ratio = loss/DepDelay)

# Add the three variables as described in the third instruction: m2
m2 <-mutate(hflights, TotalTaxi = TaxiIn + TaxiOut, ActualGroundTime = ActualElapsedTime - AirTime, Diff = TotalTaxi - ActualGroundTime)

#Filter command
# hflights is at your disposal as a tbl, with clean carrier names

# All flights that traveled 3000 miles or more
filter(hflights, Distance>=3000 )

# All flights flown by one of JetBlue, Southwest, or Delta
filter(hflights, UniqueCarrier %in% c("JetBlue","Southwest","Delta"))

# All flights where taxiing took longer than flying
filter(hflights, TaxiIn + TaxiOut> AirTime)

# hflights is already available in the workspace

# Select the flights that had JFK as their destination: c1
c1<-filter(hflights, Dest == "JFK")

# Combine the Year, Month and DayofMonth variables to create a Date column: c2
c2<-mutate(c1,Date = paste( Year, Month, DayofMonth, sep ="-"))

# Print out a selection of columns of c2
select(c2, Date, DepTime, ArrTime, TailNum)


#How many weekend flights with greated 1000 miles and Taciing less than 15
filter(hflights, DayOfWeek %in% c(6,7), Distance > 1000, TaxiIn + TaxiOut < 15)

#Summarise
# hflights and dplyr are loaded in the workspace

# Print out a summary with variables min_dist and max_dist
summarize(hflights, min_dist = min(Distance), max_dist = max(Distance))

# Print out a summary with variable max_div
summarize(filter(hflights, Diverted == 1), max_div = max(Distance))


# hflights is available

# Remove rows that have NA ArrDelay: temp1
temp1 <- filter(hflights, !is.na(ArrDelay))

# Generate summary about ArrDelay column of temp1
summarize(temp1, 
          earliest = min(ArrDelay), 
          average = mean(ArrDelay), 
          latest = max(ArrDelay), 
          sd = sd(ArrDelay))

# Keep rows that have no NA TaxiIn and no NA TaxiOut: temp2
temp2 <- filter(hflights, !is.na(TaxiIn), !is.na(TaxiOut))

# Print the maximum taxiing difference of temp2 with summarize()
summarize(temp2, max_taxi_diff = max(abs(TaxiIn - TaxiOut)))

# hflights is available with full names for the carriers

# Generate summarizing statistics for hflights
summarize(hflights, 
          n_obs = n(), 
          n_carrier = n_distinct(UniqueCarrier), 
          n_dest = n_distinct(Dest))

# All American Airline flights
aa <- filter(hflights, UniqueCarrier == "American")

# Generate summarizing statistics for aa 
summarize(aa, 
          n_flights = n(), 
          n_canc = sum(Cancelled == 1),
          avg_delay = mean(ArrDelay, na.rm = TRUE))