Textbook link
This video corresponds to the textbook section on indexing.

Key Points
We can use logicals to index vectors.
Using the function >sum()on a logical vector returns the number of entries that are true.
The logical operator “&” makes two logicals true only when they are both true.
Code
# defining murder rate as before
murder_rate <- murders$total / murders$population * 100000
# creating a logical vector that specifies if the murder rate in that state is less than or equal to 0.71
index <- murder_rate <= 0.71
# determining which states have murder rates less than or equal to 0.71
murders$state[index]
# calculating how many states have a murder rate less than or equal to 0.71
sum(index)

# creating the two logical vectors representing our conditions
west <- murders$region == "West"
safe <- murder_rate <= 1
# defining an index and identifying states with both conditions true
index <- safe & west
murders$state[index]


##################################################################
Video Correction
The code at 2:10 should read murders$state[index]

Textbook link
This video corresponds to the Here is a  textbook section on the indexing functions which, match, and %in%.

Key Points
The function which() gives us the entries of a logical vector that are true.
The function match() looks for entries in a vector and returns the index needed to access them.
We use the function %in% if we want to know whether or not each element of a first vector is in a second vector.
Code
# to determine the murder rate in Massachusetts we may do the following
ind <- which(murders$state == "Massachusetts")
murder_rate[ind]

# to obtain the indices and subsequent murder rates of New York, Florida, Texas, we do:
ind <- match(c("New York", "Florida", "Texas"), murders$state)
ind
murder_rate[ind]

# to see if Boston, Dakota, and Washington are states
c("Boston", "Dakota", "Washington") %in% murders$state
