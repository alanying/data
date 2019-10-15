########## dplyr ##########
This section corresponds to the textbook section on summarizing data.[https://rafalab.github.io/dsbook/tidyverse.html#summarizing-data]

Key points
summarize from the dplyr/tidyverse package computes summary statistics from the data frame. It returns a data frame whose column names are defined within the function call.

summarize can compute any summary function that operates on vectors and returns a single value, but it cannot operate on functions that return multiple values.
Like most dplyr functions, summarize is aware of variable names within data frames and can use them directly.
Code
library(tidyverse)
library(dslabs)
data(heights)
# compute average and standard deviation for males
s <- heights %>%
    filter(sex == "Male") %>%
    summarize(average = mean(height), standard_deviation = sd(height))
# access average and standard deviation from summary table
s$average
s$standard_deviation
# compute median, min and max
heights %>%
    filter(sex == "Male") %>%
    summarize(median = median(height),
                       minimum = min(height),
                       maximum = max(height))
# alternative way to get min, median, max in base R
quantile(heights$height, c(0, 0.5, 1))
# generates an error: summarize can only take functions that return a single value
heights %>%
    filter(sex == "Male") %>%
    summarize(range = quantile(height, c(0, 0.5, 1)))
    
    
########## the dot placeholder ##########
Textbook links
This video corresponds to the textbook section on the dot operator. [https://rafalab.github.io/dsbook/tidyverse.html#the-dot-operator]

Note that a common replacement for the dot operator is the pull function. Here is the textbook section on the pull function. [https://rafalab.github.io/dsbook/tidyverse.html#pull]


Key points
The dot operator allows you to access values stored in data that is being piped in using the %>% character. The dot is a placeholder for the data being passed in through the pipe.
The dot operator allows dplyr functions to return single vectors or numbers instead of only data frames.
us_murder_rate %>% .$rate is equivalent to us_murder_rate$rate.
Note that an equivalent way to extract a single column using the pipe is us_murder_rate %>% pull(rate). The pull function will be used in later course material.
Code
library(tidyverse)
library(dslabs)
data(murders)

murders <- murders %>% mutate(murder_rate = total/population*100000)
summarize(murders, mean(murder_rate))
# calculate US murder rate, generating a data frame
us_murder_rate <- murders %>%
    summarize(rate = sum(total) / sum(population) * 100000)
us_murder_rate
# extract the numeric US murder rate with the dot operator
us_murder_rate %>% .$rate
# calculate and extract the murder rate with one pipe
us_murder_rate <- murders %>%
    summarize(rate = sum(total) / sum(population * 100000) %>%
    .$rate

########## Group by ##########
Textbook link
This video corresponds to the textbook section on grouping then summarizing. [https://rafalab.github.io/dsbook/tidyverse.html#group-by]

Key points
The group_by function from dplyr  converts a data frame to a grouped data frame, creating groups using one or more variables.
summarize and some other dplyr functions will behave differently on grouped data frames.
Using summarize on a grouped data frame computes the summary statistics for each of the separate groups.
Code
# libraries and data
library(tidyverse)
library(dslabs)
data(heights)
data(murders)
# compute separate average and standard deviation for male/female heights
heights %>%
    group_by(sex) %>%
    summarize(average = mean(height), standard_deviation = sd(height))
# compute median murder rate in 4 regions of country
murders <- murders %>%
    mutate(murder_rate = total/population * 100000)
murders %>%
    group_by(region) %>%
    summarize(median_rate = median(murder_rate))
    
    
########## Sorting Data Table  ##########
Textbook link
This video corresponds to the textbook section on sorting data frames. [https://rafalab.github.io/dsbook/tidyverse.html#sorting-data-frames]

Key points
The arrange function from dplyr sorts a data frame by a given column.
By default, arrange sorts in ascending order (lowest to highest). To instead sort in descending order, use the function desc inside of arrange.
You can arrange by multiple levels: within equivalent values of the first level, observations are sorted by the second level, and so on.
The top_n function shows the top results ranked by a given variable, but the results are not ordered. You can combine top_n with arrange to return the top results in order.
Code
# libraries and data
library(tidyverse)
library(dslabs)
data(murders)
# set up murders object
murders <- murders %>%
    mutate(murder_rate <- total/population * 100000)

# arrange by population column, smallest to largest
murders %>% arrange(population) %>% head()

# arrange by murder rate, smallest to largest
murders %>% arrange(murder_rate) %>% head()

# arrange by murder rate in descending order
murders %>% arrange(desc(murder_rate)) %>% head()

# arrange by region alphabetically, then by murder rate within each region
murders %>% arrange(region, murder_rate) %>% head()

# show the top 10 states with highest murder rate, not ordered by rate
murders %>% top_n(10, murder_rate)

# show the top 10 states with highest murder rate, ordered by rate
murders %>% arrange(desc(murder_rate)) %>% top_n(10)

########## exercise ##########
Practice Exercise. National Center for Health Statistics
To practice our dplyr skills we will be working with data from the survey collected by the United States National Center for Health Statistics (NCHS). This center has conducted a series of health and nutrition surveys since the 1960’s.

Starting in 1999, about 5,000 individuals of all ages have been interviewed every year and then they complete the health examination component of the survey. Part of this dataset is made available via the NHANES package which can be loaded this way:

library(NHANES)
data(NHANES)
The NHANES data has many missing values. Remember that the main summarization function in R will return NA if any of the entries of the input vector is an NA. Here is an example:

library(dslabs)
data(na_example)
mean(na_example)
sd(na_example)
To ignore the NAs, we can use the na.rm argument:

mean(na_example, na.rm = TRUE)
sd(na_example, na.rm = TRUE)
Try running this code, then let us know you are ready to proceed with the analysis.

##### Exercise 5. group_by #####
Now let's practice using the group_by function.
What we are about to do is a very common operation in data science: you will split a data table into groups and then compute summary statistics for each group.
We will compute the average and standard deviation of systolic blood pressure for females for each age group separately. Remember that the age groups are contained in AgeDecade.

Use the functions filter, group_by, summarize, and the pipe %>% to compute the average and standard deviation of systolic blood pressure for females for each age group separately.
Within summarize, save the average and standard deviation of systolic blood pressure (BPSysAve) as average and standard_deviation.
Note: ignore warnings about implicit NAs. This warning will not prevent your code from running or being graded correctly.

library(dplyr)
library(NHANES)
data(NHANES)
##complete the line with group_by and summarize
NHANES %>%
      filter(Gender == "female") %>%
      group_by(AgeDecade) %>%
      summarize(average=mean(BPSysAve, na.rm=TRUE), standard_deviation=sd(BPSysAve, na.rm=TRUE))
      
##### Exercise 7. group_by example 3 #####
We can actually combine both of these summaries into a single line of code. This is because group_by permits us to group by more than one variable.

We can use group_by(AgeDecade, Gender) to group by both age decades and gender.

Create a single summary table for the average and standard deviation of systolic blood pressure using group_by(AgeDecade, Gender).
Note that we no longer have to filter!
Your code within summarize should remain the same as in the previous exercises.
Note: ignore warnings about implicit NAs. This warning will not prevent your code from running or being graded correctly.

library(NHANES)
data(NHANES)

NHANES %>% 
  group_by(AgeDecade, Gender) %>%
  summarize(average=mean(BPSysAve, na.rm=TRUE), 
  standard_deviation=sd(BPSysAve, na.rm=TRUE))


########## Exercise 8. Arrange ##########
Now we are going to explore differences in systolic blood pressure across races, as reported in the Race1 variable.

We will learn to use the arrange function to order the outcome acording to one variable.

Note that this function can be used to order any table by a given outcome. Here is an example that arranges by systolic blood pressure.

NHANES %>% arrange(BPSysAve)
If we want it in descending order we can use the desc function like this:

NHANES %>% arrange(desc(BPSysAve))
In this example, we will compare systolic blood pressure across values of the Race1 variable for males between the ages of 40-49.

Instruction
Compute the average and standard deviation for each value of Race1 for males in the age decade 40-49.
Order the resulting table from lowest to highest average systolic blood pressure.
Use the functions filter, group_by, summarize, arrange, and the pipe %>% to do this in one line of code.
Within summarize, save the average and standard deviation of systolic blood pressure as average and standard_deviation.

library(NHANES)
data(NHANES)

NHANES %>%
  group_by(Race1) %>%
  filter(AgeDecade==" 40-49", Gender=="male") %>%
  summarize(average=mean(BPSysAve, na.rm=TRUE), standard_deviation=sd(BPSysAve, na.rm=TRUE))  %>%
  arrange(average)
  
