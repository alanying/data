#1) Look at Google "What are the chances of..." to get inspriations of problems to be solved.
#2) statistical inference builds upon probability theory.
#3) Introduce important concepts such as random variables, independence,
#Monte Carlo simulation, expected values, standard errors, margin of errors,
#and the central limit theorem.

###########################################
# 1.1 Introduction to Discrete Probabilty #
###########################################

#discrete probability
#create an urn with 2 red and 3 blue beads
beads <- rep(c("red", "blue"), times = c(2,3)) 

#sample 1 bead at random. Bear in mind that this function means beads will not be replaced after each turn.
sample(beads, 1) 

#Monte Carlo Simulations is needed because we can't run simulations forever.
#On below example, if B is large enough, we will get very close to 40:60 probability

B <- 10000    # number of times to draw 1 bead
events <- replicate(B, sample(beads, 1))    # user replicate function to repeat stimulation. Draw 1 bead, B times
tab <- table(events)    # make a table of outcome counts
tab    # view count table
prop.table(tab)    # view table of outcome proportions

#user sample function, but with replacement, so we put back the bead in the urn after each turn 
events <- sample(beads, B, replace=True) 
prop.table(table(events))

#set the seeds
set.seed(1986) #try use different number every time e.g. year minus month minus day

set.seed(1)
set.seed(1, sample.kind="Rounding")    # will make R 3.6 generate a seed as in R 3.5

#Use mean function to find the probability of a logical vector
#Example... 
beads <- rep(c("red", "blue"), times = c(2,3))
beads
[1] "red" "red" "blue" "blue" "blue"

mean(beads == "blue")
[1] 0.6

#Explanation...
#R evaluates the logical statement beads == "blue", which generates the vector
#FALSE FALSE TRUE TRUE TRUE
#R coerces the logical values to numeric values
# 0 0 1 1 1

#probability distribution is simple with discrete probability 
#e.g. polling of has 44% Democrat, 44% Republican, 10% undecided, and 2% green
#continuous probability will be more complex

#independence - two events are independent when the outcome of one doesn't affect the other
#e.g. tossing a coin, no matter what result you have previously, each time is an equal chance of head/tail

#conditional probability - the probabilities change once you see the other outcomes
#e.g. blackjack after seeing 1 King, the chance of getting a King changes
# Probability of Card2 is a King GIVEN THAT Card1 is a King?
# Pr(Card 2 is a king ∣ Card 1 is a king)=3/51

# If two events  A  and  B  are independent,  Pr(A∣B)=Pr(A) because it doesn't matter what B is, probability of A doesn't change.

#Multiplication Rule - find the probablity of 2 events. 
#Probability of A multiplie by probability of B given A has already happened.
# Pr(A and B) = Pr(A)Pr(B|A)

#Black jack as example - we want an Ace and then a face card or a 10 to hit 21 points.
# Probability of Ace = 1/13
# Probability of face card or 10 = 16/51 
#[16 because...10,J,Q,K x 4] [51 because...one card, Ace is alredy shown]
# 1/13 * 16/51 = 0.02

#Multiplication rule - use induction to extend beyond 2 events
# Pr(A and B and C) = Pr(A) * Pr(B | A) * Pr(C | A and B)

#Multiplication rule - simpler with independent events
# Pr(A and B and C) = Pr(A) * Pr(B) * Pr(C)

#Hence, in real cases, assumption of independence would cause huge differencein probability

Equations:
The multiplication rule for independent events is:
Pr(A and B and C)=Pr(A)×Pr(B)×Pr(C) 

The multiplication rule for dependent events considers the conditional probability of both events occurring:
Pr(A and B)=Pr(A)×Pr(B∣A) 

We can expand the multiplication rule for dependent events to more than 2 events:
Pr(A and B and C)=Pr(A)×Pr(B∣A)×Pr(C∣A and B)

#####################
# DataCamp exercise #
#####################

# Exercise 1. Probability of cyan - generalized
cyan <- 3
magenta <- 5
yellow <- 7
# Assign a variable `p` as the probability of choosing a cyan ball from the box
p <- cyan/(cyan+magenta+yellow)
# Print the variable `p` to the console
p

# Exercise 2. Probability of not cyan - generalized
# `p` is defined as the probability of choosing a cyan ball from a box containing: 3 cyan balls, 5 magenta balls, and 7 yellow balls.
# Using variable `p`, calculate the probability of choosing any ball that is not cyan from the box
1 - p

# Exercise 3. Sampling without replacement - generalized
cyan <- 3
magenta <- 5
yellow <- 7
# The variable `p_1` is the probability of choosing a cyan ball from the box on the first draw.
p_1 <- cyan / (cyan + magenta + yellow)
# Assign a variable `p_2` as the probability of not choosing a cyan ball on the second draw without replacement.
p_2 <- (magenta + yellow)/((cyan-1) + magenta + yellow)
# Calculate the probability that the first draw is cyan and the second draw is not cyan using `p_1` and `p_2`.
p_2 * p_1

#Exercise 4. Sampling with replacement - generalized
cyan <- 3
magenta <- 5
yellow <- 7
# The variable 'p_1' is the probability of choosing a cyan ball from the box on the first draw.
p_1 <- cyan / (cyan + magenta + yellow)
# Assign a variable 'p_2' as the probability of not choosing a cyan ball on the second draw with replacement.
p_2 <- (magenta + yellow) / (cyan + magenta + yellow)
# Calculate the probability that the first draw is cyan and the second draw is not cyan using `p_1` and `p_2`.
p_1 * p_2


###########################################
# 1.2 Combinations and Permutations       #
###########################################
Textbook link

Here is a link to the textbook section on combinations and permutations.
[https://rafalab.github.io/dsbook/probability.html#combinations-and-permutations]

Key points:
paste joins two strings and inserts a space in between.
expand.grid gives the combinations of 2 vectors or lists.
permutations(n,r) from the gtools package lists the different ways that r items can be selected from a set of n options when order matters.
combinations(n,r) from the gtools package lists the different ways that r items can be selected from a set of n options when order does not matter.
Code: Introducing paste and expand.grid

# joining strings with paste
number <- "Three"
suit <- "Hearts"
paste(number, suit)

# joining vectors element-wise with paste
paste(letters[1:5], as.character(1:5))

# generating combinations of 2 vectors with expand.grid
expand.grid(pants = c("blue", "black"), shirt = c("white", "grey", "plaid"))

Code: Generating a deck of cards

suits <- c("Diamonds", "Clubs", "Hearts", "Spades")
numbers <- c("Ace", "Deuce", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Jack", "Queen", "King")
deck <- expand.grid(number = numbers, suit = suits)
deck <- paste(deck$number, deck$suit)   # paste them together so we can pick each of them as an individual

# probability of drawing a king
kings <- paste("King", suits)
mean(deck %in% kings)     # mean gives us the average of when kings happens, thus the probablity

Code: Permutations and combinations

library(gtools)
permutations(5,2)    # ways to choose 2 numbers in order from 1:5
# Notice that the order matters. So 3, 1 is different than 1, 3, So it appears in our permutations. Also notice that 1, 1; 2, 2; and 3, 3 don't appear, because once we pick a number, it can't appear again.  

all_phone_numbers <- permutations(10, 7, v = 0:9)   # added a vector that only picks up 0-9, isntead of 1-10
n <- nrow(all_phone_numbers)
index <- sample(n, 5)
all_phone_numbers[index,]

permutations(3,2)    # order matters
combinations(3,2)    # order does not matter

Code: Probability of drawing a second king given that one king is drawn

hands <- permutations(52,2, v = deck)   # all possible ways to draw 2 cards from ther deck
first_card <- hands[,1]     # grab first column, first card
second_card <- hands[,2]    # grab second column, second card
sum(first_card %in% kings)  # 204, but what fraction of these 204 have also a kind on second card?
 
sum(first_card %in% kings & second_card %in% kings) / sum(first_card %in% kings)  #3 out 3 of 51
# using Sum is equivalent to Mean, will get the same answer
# this is R version of the mutliplication rule    Pr(B|A) = Pr(A&B)/Pr(A)

Code: Probability of a natural 21 in blackjack

aces <- paste("Ace", suits)

facecard <- c("King", "Queen", "Jack", "Ten")
facecard <- expand.grid(number = facecard, suit = suits)
facecard <- paste(facecard$number, facecard$suit)

hands <- combinations(52, 2, v=deck) # all possible hands

# probability of a natural 21 given that the ace is listed first in `combinations`
mean(hands[,1] %in% aces & hands[,2] %in% facecard)

# probability of a natural 21 checking for both ace first and ace second
mean((hands[,1] %in% aces & hands[,2] %in% facecard)|(hands[,2] %in% aces & hands[,1] %in% facecard))
 
# both above get same answer due to the way Combination works, that orders don't matter and counts will not be repeated.

Code: Monte Carlo simulation of natural 21 in blackjack

Note that your exact values will differ because the process is random and the seed is not set.

# code for one hand of blackjack
hand <- sample(deck, 2)
hand

# code for B=10,000 hands of blackjack
B <- 10000
results <- replicate(B, {
  hand <- sample(deck, 2)
  (hand[1] %in% aces & hand[2] %in% facecard) | (hand[2] %in% aces & hand[1] %in% facecard)
})
mean(results)


# The birthday problem
Here is a link to the textbook section on the birthday problem.
[https://rafalab.github.io/dsbook/probability.html#birthday-problem]

Key points

duplicated takes a vector and returns a vector of the same length with TRUE for any elements that have appeared previously in that vector.
We can compute the probability of shared birthdays in a group of people by modeling birthdays as random draws from the numbers 1 through 365. We can then use this sampling model of birthdays to run a Monte Carlo simulation to estimate the probability of shared birthdays.
Code: The birthday problem

# checking for duplicated bdays in one 50 person group
n <- 50
bdays <- sample(1:365, n, replace = TRUE)    # generate n random birthdays, 50 times, with replacement
any(duplicated(bdays))    # check if any birthdays are duplicated

# Monte Carlo simulation with B=10000 replicates
B <- 10000
results <- replicate(B, {    # returns vector of B logical values i.e. repeat simulation B number of times
    bdays <- sample(1:365, n, replace = TRUE)
    any(duplicated(bdays))
})
mean(results)    # calculates proportion of groups with duplicated bdays
 

## sapply
extbook links
The textbook discussion of the basics of sapply can be found in this textbook section.
[https://rafalab.github.io/dsbook/programming-basics.html#vectorization]
The textbook discussion of sapply for the birthday problem can be found within the birthday problem section.
[https://rafalab.github.io/dsbook/probability.html#birthday-problem]
 
Key points:
Some functions automatically apply element-wise to vectors, such as sqrt and *.
However, other functions do not operate element-wise by default. This includes functions we define ourselves.
The function sapply(x, f) allows any other function f to be applied element-wise to the vector x.

The probability of an event happening is 1 minus the probability of that event not happening:
 
          Pr(event)=1−Pr(no event) 
 
We can compute the probability of shared birthdays mathematically:

       Pr(shared birthdays) = 1−Pr(no shared birthdays) = 1−(1 × 364/365 × 363/365 ×...× 365−n+1/365) 
 
Code: Function for calculating birthday problem Monte Carlo simulations for any value of n

Note that the function body of compute_prob is the code that we wrote in the previous video. If we write this code as a function, we can use sapply to apply this function to several values of n.


# function to calculate probability of shared bdays across n people
compute_prob <- function(n, B = 10000) {
    same_day <- replicate(B, {
        bdays <- sample(1:365, n, replace = TRUE)
        any(duplicated(bdays))
    })
    mean(same_day)
}

n <- seq(1, 60)

#we can use for loop, but for loop is rare in R. Operate on vectors in element fashion. For example...
x <- 1:10  # X is now the vector starting at 1 and ending at 10,
sqrt(x)  # we compute the square root of x, it actually computes the square root for each element.
y <- 1:10  # Equally, if we define y to be 1 through 10, 
x*y  # and then multiply x by y, it mutiple each element 1 by 1. So no need for loop.
  
Code: Element-wise operation over vectors and sapply

x <- 1:10
sqrt(x)    # sqrt operates on each element of the vector

y <- 1:10
x*y    # * operates element-wise on both vectors

compute_prob(n)    # does not iterate over the vector n without sapply

x <- 1:10
sapply(x, sqrt)    # this is equivalent to sqrt(x)

prob <- sapply(n, compute_prob)    # element-wise application of compute_prob to n
plot(n, prob)

Computing birthday problem probabilities with sapply
# simpler maths to compute of it NOT happening i.e. probability of who has unique birthday. 
 # So the probability for the 1st person to have unique birthday is 1.
# function for computing exact probability of shared birthdays for any n
exact_prob <- function(n){
    prob_unique <- seq(365, 365-n+1)/365   # vector of fractions for mult. rule. 365-n+1 means the index of your turn minus 1. e.g. Pr(3rd person has unique bday | 1st & 2nd have unique bdays) = 363/365
    1 - prod(prob_unique)    # calculate prob of no shared birthdays and subtract from 1
}

# applying function element-wise to vector of n values
eprob <- sapply(n, exact_prob)

# plotting Monte Carlo results and exact probabilities on same graph
plot(n, prob)    # plot Monte Carlo results
lines(n, eprob, col = "red")    # add line for exact prob
 

## How many Monte Carlo experiments are enough? 
Textbook link:
Here is a link to the matching textbook section.
 [https://rafalab.github.io/dsbook/probability.html#infinity-in-practice]

Key points

The larger the number of Monte Carlo replicates  B , the more accurate the estimate.
Determining the appropriate size for  B  can require advanced statistics.
One practical approach is to try many sizes for  B  and look for sizes that provide stable estimates.
# it means we wopn't know how many times is enough, really. However, we can usetheoretical statstic to see the stability of estimate.
  
Code: Estimating a practical value of B

This code runs Monte Carlo simulations to estimate the probability of shared birthdays using several B values and plots the results. When B is large enough that the estimated probability stays stable, then we have selected a useful value of B. 

B <- 10^seq(1, 5, len = 100)    # defines vector of many B values e.g. 10,20,40,100,etc.
compute_prob <- function(B, n = 22){    # function to run Monte Carlo simulation with each B
    same_day <- replicate(B, {
        bdays <- sample(1:365, n, replace = TRUE)
        any(duplicated(bdays))
    })
    mean(same_day)
}
prob <- sapply(B, compute_prob)    # apply compute_prob to many values of B
plot(log10(B), prob, type = "l")    # plot a line graph of estimates  
# the graph starts to stablise towards right side indicates when we have stabler estimates.
  
 
# datacamp exercise
# Exercise 2. Sampling with replacement
cyan <- 3
magenta <- 5
yellow <- 7

# Assign the variable 'p_yellow' as the probability that a yellow ball is drawn from the box.
p_yellow <- yellow/(cyan+magenta+yellow)
# Using the variable 'p_yellow', calculate the probability of drawing a yellow ball on the sixth draw. Print this value to the console.

p_yellow
# the events are independant. So Pr(yellow|yellow) = Pr(yellow). So Pr(yellow|yellow|yellow|yellow|yellow|yellow|yellow) = Pr(yellow)
  
 
# Exercise 3. Rolling a die

## Assign the variable 'p_no6' as the probability of not seeing a 6 on a single roll.
p_no6 <- 5/6

# Calculate the probability of not seeing a 6 on six rolls using `p_no6`. Print your result to the console: do not assign it to a variable.
(p_no6)^6    # because outcomes are dependent, so times it 6 times
  
  
Exercise 4. Probability the Celtics win a game
Two teams, say the Celtics and the Cavs, are playing a seven game series. The Cavs are a better team and have a 60% chance of winning each game.

What is the probability that the Celtics win at least one game? Remember that the Celtics must win one of the first four games, or the series will be over!
  
# Assign the variable `p_cavs_win4` as the probability that the Cavs will win the first four games of the series.
p_cavs_win4 <- (0.6)^4

# Using the variable `p_cavs_win4`, calculate the probability that the Celtics win at least one game in the first four games of the series.
1 - p_cavs_win4   # because it's the opposite of Cavs wining 4 times in a row


## Exercise 5. Monte Carlo simulation for Celtics winning a game
Create a Monte Carlo simulation to confirm your answer to the previous problem by estimating how frequently the Celtics win at least 1 of 4 games. Use B <- 10000 simulations.
The provided sample code simulates a single series of four random games, simulated_games.
  
# This line of example code simulates four independent random games where the Celtics either lose or win. Copy this example code to use within the `replicate` function.
simulated_games <- sample(c("lose","win"), 4, replace = TRUE, prob = c(0.6, 0.4))

# The variable 'B' specifies the number of times we want the simulation to run. Let's run the Monte Carlo simulation 10,000 times.
B <- 10000

# Use the `set.seed` function to make sure your answer matches the expected result after random sampling.
set.seed(1)

# Create an object called `celtic_wins` that replicates two steps for B iterations: (1) generating a random four-game series `simulated_games` using the example code, then (2) determining whether the simulated series contains at least one win for the Celtics.
celtic_wins <- replicate(B, {    
    simulated_games <- #set.seed(1) 
    sample(c("lose","win"), 4, replace = TRUE, prob = c(0.6, 0.4))
    any(simulated_games == "win")
})

# Calculate the frequency out of B iterations that the Celtics won at least one game. Print your answer to the console.
mean(celtic_wins)
  
 
