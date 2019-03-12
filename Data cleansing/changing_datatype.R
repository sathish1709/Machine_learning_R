# Preview students2 with str()
str(students2)

# Load the lubridate package
library(lubridate)

# Parse as date
"17 Sep 2015"
dmy("17 Sep 2015")

# Parse as date and time (with no seconds!)
"July 15, 2012 12:56"
mdy_hm("July 15, 2012 12:56")

# Coerce dob to a date (with no time)
students2$dob <- ymd(students2$dob)

# Coerce nurse_visit to a date and time
students2$nurse_visit <- ymd_hms(students2$nurse_visit)


# Look at students2 once more with str()
str(students2)


# Load the stringr package
library(stringr)

# Trim all leading and trailing whitespace
c("   Filip ", "Nick  ", " Jonathan")
str_trim(c("   Filip ", "Nick  ", " Jonathan"))

# Pad these strings with leading zeros
c("23485W", "8823453Q", "994Z")
str_pad(c("23485W", "8823453Q", "994Z"),width = 9,side="left", pad = "0")

# Print state abbreviations
states

# Make states all uppercase and save result to states_upper
states_upper <-toupper(states)

# Make states_upper all lowercase again
tolower(states_upper)

# Copy of students2: students3
students3 <- students2

# Look at the head of students3
head(students3)

# Detect all dates of birth (dob) in 1997
str_detect(students3$dob, "1997")

# In the sex column, replace "F" with "Female" ...
students3$sex <- str_replace(students3$sex, "F", "Female")

# ... and "M" with "Male"
students3$sex <- str_replace(students3$sex, "M", "Male")

# View the head of students3
head(students3)

