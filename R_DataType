Call a library:
library (dslabs)

Define varible:
a <- 1


Data type

The function “class” helps us determine the type of an object.
Data frames can be thought of as tables with rows representing observations and columns representing different variables.
To access data from columns of a data frame, we use the dollar sign symbol, which is called the accessor.
A vector is an object consisting of several entries and can be a numeric vector, a character vector, or a logical vector.
We use quotes to distinguish between variable names and character strings.
Factors are useful for storing categorical data, and are more memory efficient than storing characters.
Code

# loading the dslabs package and the murders dataset
library(dslabs)
data(murders)

# determining that the murders dataset is of the "data frame" class
class(murders)
# finding out more about the structure of the object
str(murders)
# showing the first 6 lines of the dataset
head(murders)

# using the accessor operator to obtain the population column
murders$population
# displaying the variable names in the murders dataset
names(murders)
# determining how many entries are in a vector
pop <- murders$population
length(pop)
# vectors can be of class numeric and character
class(pop)
class(murders$state)

# logical vectors are either TRUE or FALSE
z <- 3 == 2
z
class(z)

# factors are another type of class
class(murders$region)
# obtaining the levels of a factor
levels(murders$region)
