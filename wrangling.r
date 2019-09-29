This video corresponds to the textbook section on mutate, filter, and select and the textbook section on the pipe operator.

Note: in the textbook, the dplyr package is introduced in the context of the tidyverse, a collection of R packages

Key Points
To change a data table by adding a new column, or changing an existing one, we use the mutate function.
To filter the data by subsetting rows, we use the function filter.
To subset the data by selecting specific columns, we use the select function.
We can perform a series of operations by sending the results of one function to another function using what is called the pipe operator, %>%.
Code
# installing and loading the dplyr package
install.packages("dplyr")
library(dplyr)

# adding a column with mutate
library(dslabs)
data("murders")
murders <- mutate(murders, rate = total / population * 100000)

# subsetting with filter
filter(murders, rate <= 0.71)

# selecting columns with select
new_table <- select(murders, state, region, rate)

# using the pipe
murders %>% select(state, region, rate) %>% filter(rate <= 0.71)
