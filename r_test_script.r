#basic R test script 

# Load the required packages
library(data.table)
library(stringr)
library(dplyr)
library(lubridate)

# Test data.table
dt <- data.table(x = 1:5, y = letters[1:5])
print(dt)  # Print the data.table

# Test stringr
text <- "Hello, World!"
print(str_length(text))  # Print the length of the string
print(str_replace(text, "World", "R"))  # Replace "World" with "R"

# Test dplyr
mtcars <- as.data.table(mtcars)  # Convert mtcars to data.table
filtered_data <- mtcars %>%
  filter(cyl == 4) %>%
  select(mpg, cyl, disp)
print(filtered_data)  # Print filtered data

# Test lubridate
today <- today()
print(today)  # Print today's date

next_week <- today + weeks(1)
print(next_week)  # Print date one week from today

date_string <- "2023-05-31"
parsed_date <- ymd(date_string)
print(parsed_date)  # Print parsed date from string