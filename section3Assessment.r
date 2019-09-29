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


