#conditionals, functions, for loops
######################################## conditionals ########################################
Textbook link
This video corresponds to the textbook section on basic conditional expressions.

Key Points
The most common conditional expression in programming is an if-else statement, which has the form "if [condition], perform [expression], else perform [alternative expression]".
The ifelse() function works similarly to an if-else statement, but it is particularly useful since it works on vectors by examining each element of the vector and returning a corresponding answer accordingly.
The any() function takes a vector of logicals and returns true if any of the entries are true.
The all() function takes a vector of logicals and returns true if all of the entries are true.
Code
# an example showing the general structure of an if-else statement
a <- 0
if(a!=0){
  print(1/a)
} else{
  print("No reciprocal for 0.")
}

# an example that tells us which states, if any, have a murder rate less than 0.5
library(dslabs)
data(murders)
murder_rate <- murders$total / murders$population*100000
ind <- which.min(murder_rate)
if(murder_rate[ind] < 0.5){
  print(murders$state[ind]) 
} else{
  print("No state has murder rate that low")
}

# changing the condition to < 0.25 changes the result
if(murder_rate[ind] < 0.25){
  print(murders$state[ind]) 
} else{
  print("No state has a murder rate that low.")
}

# the ifelse() function works similarly to an if-else conditional
a <- 0
ifelse(a > 0, 1/a, NA)

# the ifelse() function is particularly useful on vectors
a <- c(0,1,2,-4,5)
result <- ifelse(a > 0, 1/a, NA)

# the ifelse() function is also helpful for replacing missing values
data(na_example)
no_nas <- ifelse(is.na(na_example), 0, na_example) 
sum(is.na(no_nas))

# the any() and all() functions evaluate logical vectors
z <- c(TRUE, TRUE, FALSE)
any(z)
all(z)

######################################## functions ########################################

Textbook link
This video corresponds to the textbook section on Basic Functions.

Key points
The R function, called function() tells R you are about to define a new function.
Functions are objects, so must be assigned a variable name with the arrow operator.
The general way to define functions is: (1) decide the function name, which will be an object, (2) type function() with your function's arguments in parentheses, (3) write all the operations inside brackets.
Variables defined inside a function are not saved in the workspace.
Code
# example of defining a function to compute the average of a vector x
avg <- function(x){
  s <- sum(x)
  n <- length(x)
  s/n
}

# we see that the above function and the pre-built R mean() function are identical
x <- 1:100
identical(mean(x), avg(x))

# variables inside a function are not defined in the workspace
s <- 3
avg(1:10)
s

# the general form of a function
my_function <- function(VARIABLE_NAME){
  perform operations on VARIABLE_NAME and calculate VALUE
  VALUE
}

# functions can have multiple arguments as well as default values
avg <- function(x, arithmetic = TRUE){
  n <- length(x)
  ifelse(arithmetic, sum(x)/n, prod(x)^(1/n))
}


######################################## For loops ########################################
Textbook link
This video corresponds to the textbook section on for-loops.
https://rafalab.github.io/dsbook/programming-basics.html#for-loops

Key points
For-loops perform the same task over and over while changing the variable.  They let us define the range that our variable takes, and then changes the value with each loop and evaluates the expression every time inside the loop.
The general form of a for-loop is: "For i in [some range], do operations".  This i changes across the range of values and the operations assume i is a value you're interested in computing on.
At the end of the loop, the value of i is the last value of the range.
Code
# creating a function that computes the sum of integers 1 through n
compute_s_n <- function(n){
  x <- 1:n
  sum(x)
}

# a very simple for-loop
for(i in 1:5){
  print(i)

# a for-loop for our summation
m <- 25
s_n <- vector(length = m) # create an empty vector
for(n in 1:m){
  s_n[n] <- compute_s_n(n)
}

# creating a plot for our summation function
n <- 1:m
plot(n, s_n)

# a table of values comparing our function to the summation formula
head(data.frame(s_n = s_n, formula = n*(n+1)/2))

# overlaying our function with the summation formula
plot(n, s_n)
lines(n, n*(n+1)/2)
Annotate

################################## exercise from DataCamp
# question 1 - 
# Write a function compute_s_n with argument n that for any given n computes the sum of 1 + 2^2 + ...+ n^2
compute_s_n <- function(n){
  s <- 0
  for(i in 1:n){
  s <- s + i * i
  } 
  sum(s)
}
# Report the value of the sum when n=10
compute_s_n(10)

#Quesiton 2 - 
# # Define a function and store it in `compute_s_n`
compute_s_n <- function(n){
  x <- 1:n
  sum(x^2)
}
# Create a vector for storing results
s_n <- vector("numeric", 25)
# write a for-loop to store the results in s_n
for(i in 1:25){
  s_n[i] <- compute_s_n(i)
}

#Question 3 - plot S^n versus n
# Define the function
compute_s_n <- function(n){
  x <- 1:n
  sum(x^2)
}
# Define the vector of n
n <- 1:25
# Define the vector to store data
s_n <- vector("numeric", 25)
for(i in n){
  s_n[i] <- compute_s_n(i)
}
#  Create the plot 
plot(n, s_n)

################################ exercise
#####How many individuals in the heights dataset have a height less than 5 feet?
#####add a ft vector to heights dataset, and declare it as a new table heights3
heights3 <- mutate(heights, ft = in_to_ft(heights$height))
> head(heights3)
     sex height       ft
1   Male     75 6.250000
2   Male     70 5.833333
3   Male     68 5.666667
4   Male     74 6.166667
5   Male     61 5.083333
6 Female     65 5.416667
#####use count funciton to solve the question
> count(heights3, heights3$ft < 5)
# A tibble: 2 x 2
  `heights3$ft < 5`     n
  <lgl>             <int>
1 FALSE              1030
2 TRUE                 20
#####user sum function to solve the question
> sum(ifelse(heights3$ft < 5, 1, 0))
[1] 20
> 
