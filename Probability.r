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
