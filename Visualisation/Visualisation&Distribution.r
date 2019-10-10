##### section 1.1 #####
##### Key points #####
Plots of data easily communicate information that is difficult to extract from tables of raw values.
Data visualization is a key component of exploratory data analysis (EDA), in which the properties of data are explored through visualization and summarization techniques.
Data visualization can help discover biases, systematic errors, mistakes and other unexpected problems in data before those data are incorporated into potentially flawed analysis.
This course covers the basics of data visualization and EDA in R using the ggplot2 package and motivating examples from world health, economics and infectious disease.

Key points
The most basic statistical summary of a list of objects is its distribution.
In some cases, data can be summarized by a two-number summary: the average and standard deviation. We will learn to use data visualization to determine when that is appropriate.

##### data type #####
categorical e.g. gender, region
categorical - ordinal data e.g. spice mild/midium/hot

numerical e.g. population, heights, murder rates
numerical - continous e.g. heights 68.12
numerical - discrete e.g. population size as it has to be round number

##### exercise #####
name(heights)
return name of the vector of the table heights

unique(heights$height)
return all unique value of height

length(unique(heights$height))
return the length of the dataset

table(heighs$height)
return a table of fequency for each uniqe height


##### section 1.2 #####
##### Intro to Distribution #####
Textbook links
This video corresponds to the following sections:
textbook case study of describing student heights [https://rafalab.github.io/dsbook/distributions.html#case-study-describing-student-heights]
textbook section on the distribution function [https://rafalab.github.io/dsbook/distributions.html#distribution-function]
textbook section on the cumulative distribution function [https://rafalab.github.io/dsbook/distributions.html#cdf-intro]
textbook section on histograms [https://rafalab.github.io/dsbook/distributions.html#histograms]

Key points
A distribution is a function or description that shows the possible values of a variable and how often those values occur.
For categorical variables, the distribution describes the proportions of each category.
A frequency table is the simplest way to show a categorical distribution. Use prop.table to convert a table of counts to a frequency table. Barplots display the distribution of categorical variables and are a way to visualize the information in frequency tables.
For continuous numerical data, reporting the frequency of each unique entry is not an effective summary as many or most values are unique. Instead, a distribution function is required.
The cumulative distribution function (CDF) is a function that reports the proportion of data below a value  a  for all values of  a :  F(a)=Pr(x≤a) .
The proportion of observations between any two values  a  and  b  can be computed from the CDF as  F(b)−F(a) .
A histogram divides data into non-overlapping bins of the same size and plots the counts of number of values that fall in that interval.

Code
# load the dataset
library(dslabs)
data(heights)

# make a table of category proportions
prop.table(table(heights$sex))

Creating other graphs from the video
You will learn to create barplots and histograms in a later section of this course.


##### section 1.2 #####
##### Al's summary:The data are normal when it matches with with what Standard Deviation predicted, like a bell curve
##### histogram plots has 'count' as y axis; density plots has 'density' as y axis
##### useful to predict data without the entier list

Textbook link
For more information, consult this textbook section on the normal distribution. [https://rafalab.github.io/dsbook/distributions.html#normal-distribution]

Key points
The normal distribution:
Is centered around one value, the mean
Is symmetric around the mean
Is defined completely by its mean ( μ ) and standard deviation (  σ  )
Always has the same proportion of observations within a given distance of the mean (for example, 95% within 2  σ )
The standard deviation is the average distance between a value and the mean value.
Calculate the mean using the mean function.
Calculate the standard deviation using the sd function or manually. 
Standard units describe how many standard deviations a value is away from the mean. The z-score, or number of standard deviations an observation  x  is away from the mean  μ :
Z=x−μσ 

Compute standard units with the scale function.
Important: to calculate the proportion of values that meet a certain condition, use the mean function on a logical vector. Because TRUE is converted to 1 and FALSE is converted to 0, taking the mean of this vector yields the proportion of TRUE.
Equation for the normal distribution
The normal distribution is mathematically defined by the following formula for any mean  μ  and standard deviation  σ :

Pr(a<x<b)=∫ba12π√σe−12(x−μσ)2dx 

Code
# define x as vector of male heights
library(tidyverse)
library(dslabs)
data(heights)
index <- heights$sex=="Male"
x <- heights$height[index]
# calculate the mean and standard deviation manually
average <- sum(x)/length(x)
SD <- sqrt(sum(x - average)^2)/length(x)
# built-in mean and sd functions - note that the audio and printed values disagree
average <- mean(x)
SD <- sd(x)
c(average = average, SD = SD)
# calculate standard units
z <- scale(x)
# calculate proportion of values within 2 SD of mean
mean(abs(z) < 2)
Note about the sd function: The built-in R function sd calculates the standard deviation, but it divides by length(x)-1 instead of length(x). When the length of the list is large, this difference is negligible and you can use the built-in sd function. Otherwise, you should compute  σ  by hand. For this course series, assume that you should use the sd function unless you are told not to do so.

########## exercise 1 Proportions ###########
What proportion of the data is between 69 and 72 inches (taller than 69 but shorter or equal to 72)? A proportion is between 0 and 1.
Use the mean function in your code. Remember that you can use mean to compute the proportion of entries of a logical vector that are TRUE.

library(dslabs)
data(heights)
x <- heights$height[heights$sex == "Male"]

y <- x>69 & x<=72
mean(y)

########## exercise 2 Averages and Standard Deviations ###########
Use the normal approximation to estimate the proportion the proportion of the data that is between 69 and 72 inches.
Note that you can't use x in your code, only avg and stdev. Also note that R has a function that may prove very helpful here - check out the pnorm function (and remember that you can get help by using ?pnorm).
Explanation: [https://courses.edx.org/courses/course-v1:HarvardX+PH125.2x+2T2019/courseware/1772ea155e374ad99d45629d5a572854/558d8d460f814d93b7d5bc1c243aef20/?child=first]

library(dslabs)
data(heights)
x <- heights$height[heights$sex=="Male"]
avg <- mean(x)
stdev <- sd(x)

pnorm(72, avg, stdev) - pnorm(69, avg, stdev)
[1] 0.3061779

########## Exercise 3. Approximations ##########
library(dslabs)
data(heights)
x <- heights$height[heights$sex == "Male"]
exact <- mean(x > 79 & x <= 81)

avg <- mean(x)
stdev <- sd(x)
approx <- pnorm(81, avg, stdev) - pnorm(79, avg, stdev)
exact/approx

########## Exercise 4. Seven footers and the NBA ##########
Using the normal approximation, estimate the proportion of adult men that are taller than 7 feet, referred to as seven footers. Remember that 1 foot equals 12 inches.
Use the pnorm function. Note that pnorm finds the proportion less than or equal to a given value, but you are asked to find the proportion greater than that value.
Print out your estimate; don't store it in an object.

# use pnorm to calculate the proportion over 7 feet (7*12 inches)
pnorm(7*12, 69, 3, lower.tail = FALSE)


########## Exercise 5. Estimating the number seven footers ##########
Now we have an approximation for the proportion, call it p, of men that are 7 feet tall or taller.
We know that there are about 1 billion men between the ages of 18 and 40 in the world, the age range for the NBA.
Can we use the normal distribution to estimate how many of these 1 billion men are at least seven feet tall?

Use your answer to the previous exercise to estimate the proportion of men that are seven feet tall or taller in the world and store that value as p.
Then multiply this value by 1 billion (10^9) round the number of 18-40 year old men who are seven feet tall or taller to the nearest integer with round. (Do not store this value in an object.)

p <- pnorm(7*12, 69, 3, lower.tail = FALSE)
round(p*(10^9))

########## Exercise 6. How many seven footers are in the NBA? ##########
There are about 10 National Basketball Association (NBA) players that are 7 feet tall or higher.

Use your answer to exercise 4 to estimate the proportion of men that are seven feet tall or taller in the world and store that value as p.
Use your answer to the previous exercise (exercise 5) to round the number of 18-40 year old men who are seven feet tall or taller to the nearest integer and store that value as N.
Then calculate the proportion of the world's 18 to 40 year old seven footers that are in the NBA. (Do not store this value in an object.)

p <- pnorm(7*12, 69, 3, lower.tail = FALSE)
N <- round(p*(10^9))
10/N

########## Exercise 7. Lebron James' height ##########
In the previous exerceise we estimated the proportion of seven footers in the NBA using this simple code:

p <- 1 - pnorm(7*12, 69, 3)
N <- round(p * 10^9)
10/N
Repeat the calculations performed in the previous question for Lebron James' height: 6 feet 8 inches. There are about 150 players, instead of 10, that are at least that tall in the NBA.
Report the estimated proportion of people at least Lebron's height that are in the NBA.

## Change the solution to previous answer
p <- 1 - pnorm(6*12+8, 69, 3)
N <- round(p * 10^9)
150/N

########## Exercise 8. Interpretation ##########
In answering the previous questions, we found that it is not at all rare for a seven footer to become an NBA player.
What would be a fair critique of our calculations?

As seen in exercise 3, the normal approximation tends to underestimate the extreme values. It's possible that there are more seven footers than we predicted.

########## Section 1.3 Quantiles, Percentiles, and Boxplots ##########
########## Quantile-Quantile Plots ##########

########## Alan note: mean(x <= 69.5) #q     ##########
########## 0.515 #p                          ##########
##########
                                                                                    
Textbook link
This video corresponds to the textbook section on quantile-quantile plots. [https://rafalab.github.io/dsbook/distributions.html#quantile-quantile-plots]

Key points
Quantile-quantile plots, or QQ-plots, are used to check whether distributions are well-approximated by a normal distribution.
Given a proportion  p , the quantile  q  is the value such that the proportion of values in the data below  q  is  p .
In a QQ-plot, the sample quantiles in the observed data are compared to the theoretical quantiles expected from the normal distribution. If the data are well-approximated by the normal distribution, then the points on the QQ-plot will fall near the identity line (sample = theoretical).
Calculate sample quantiles (observed quantiles) using the quantile function.
Calculate theoretical quantiles with the qnorm function. qnorm will calculate quantiles for the standard normal distribution ( μ=0,σ=1 ) by default, but it can calculate quantiles for any normal distribution given mean and sd arguments. We will learn more about qnorm in the probability course.
Note that we will learn alternate ways to make QQ-plots with less code later in the series.
Code
# define x and z
library(tidyverse)
library(dslabs)
data(heights)
index <- heights$sex=="Male"
x <- heights$height[index]
z <- scale(x)
# proportion of data below 69.5
mean(x <= 69.5)
# calculate observed and theoretical quantiles
p <- seq(0.05, 0.95, 0.05)
observed_quantiles <- quantile(x, p)
theoretical_quantiles <- qnorm(p, mean = mean(x), sd = sd(x))
# make QQ-plot
plot(theoretical_quantiles, observed_quantiles)
abline(0,1)

# make QQ-plot with scaled values
observed_quantiles <- quantile(z, p)
theoretical_quantiles <- qnorm(p) 
plot(theoretical_quantiles, observed_quantiles)
abline(0,1)

########## boxplot ##########
Textbook link
This video corresponds to the textbook section on boxplots. [https://rafalab.github.io/dsbook/distributions.html#boxplots]

Key points
When data do not follow a normal distribution and cannot be succinctly summarized by only the mean and standard deviation, an alternative is to report a five-number summary: range (ignoring outliers) and the quartiles (25th, 50th, 75th percentile).
In a boxplot, the box is defined by the 25th and 75th percentiles and the median is a horizontal line through the box. The whiskers show the range excluding outliers, and outliers are plotted separately as individual points.
The interquartile range is the distance between the 25th and 75th percentiles.
Boxplots are particularly useful when comparing multiple distributions.
We discuss outliers in a later video.
