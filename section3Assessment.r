#Querstion 1 - First, determine the average height in this dataset. Then create a logical vector ind with the indices for those individuals who are above average height.
How many individuals in the dataset are above average height?

#get the avgerage heights
avg <- mean(heights$height)

#index all records above average height, as logical vector: True/False
ind <- heights$height > avg

#count how many are above the average
sum(ind)

#Question 2 - How many individuals in the dataset are above average height and are female?

#logical vector (True/False) of: heights above average
tall <- heights$height > avg

#logical vector (True/False) of: get all the female
women <- hieghts$sex == "Female"

#index female who are above average height
tall_women <- tall & women


#Question 3 - If you use mean on a logical (TRUE/FALSE) vector, it returns the proportion of observations that are TRUE.
#What proportion of individuals in the dataset are female? (Report 3 significant digits)
mean(women)

#Question 4 - This question takes you through three steps to determine the sex of the individual with the minimum height.
#Determine the minimum height in the heights dataset.
min(hiehgts$height)

#Question 4b - Use the match() function to determine the index of the individual with the minimum height.
#match the hight of 50 to the height vector
min_h <- match(c("50"), heights$height)

#Question 4c - Subset the sex column of the dataset by the index in 4b to determine the individual’s sex.
#get the sex vector, by the index of min_h
heights$sex[min_h]

#Question 5 - This question takes you through three steps to determine how many of the integer height values between the minimum and maximum heights are not actual heights of individuals in the heights dataset.
#5a - Determine the maximum height.
max(heights$height)

#5b - Which integer values are between the maximum and minimum heights? For example, if the minimum height is 10.2 and the maximum height is 20.8, your answer should be x <- 11:20 to capture the integers in between those values. (If either the maximum or minimum height are integers, include those values too.)
#Write code to create a vector x that includes the integers between the minimum and maximum heights.
#There are multiple ways to solve this problem, but the grader expects you to use the format in the problem description.
x <- min(heights$height):max(heights$height)

#5c - How many of the integers in x are NOT heights in the dataset?
#(Use the sum() and %in% functions in addition to the ! operator.)

#logical vector (True/False) of: x range of integers are found in height
heights$height %in% x

#add the ! operator to get the opposite: T/F for x NOT in height
!(x %in% heights$height)

#count the index
sum(!(x %in% heights$height))
