#1) Look at Google "What are the chances of..." to get inspriations of problems to be solved.
#2) statistical inference builds upon probability theory.
#3) Introduce important concepts such as random variables, independence,
#Monte Carlo simulation, expected values, standard errors, margin of errors,
#and the central limit theorem.

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
# Pr(Card 2 is a king∣Card 1 is a king)=3/51

# If two events  A  and  B  are independent,  Pr(A∣B)=Pr(A) 

