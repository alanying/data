online answers
https://github.com/datasciencedojo/IntroDataVisualizationWithRAndGgplot2/blob/master/IntroDataVizRAndGgplot2.R

library(dplyr)
library(ggplot2)
library(dslabs)
#install.packages("ggrepel") #text/label repel function
library(ggrepel)

options(digits = 3)    # report 3 significant digits
library(tidyverse)
library(titanic)
titanic <- titanic_train %>%
  select(Survived, Pclass, Sex, Age, SibSp, Parch, Fare) %>%
  mutate(Survived = factor(Survived),
         Pclass = factor(Pclass),
         Sex = factor(Sex))


GA <- ggplot(titanic_train, aes(x=Age, color=Sex)) + 
  geom_density()

GA <- titanic_train %>% 
  filter(Sex == "female") %>%
  ggplot(aes(Age)) +
  geom_histogram()

GA <- titanic_train %>% 
  ggplot(aes(x=Sex, y=Age))+ 
  geom_point()

GA <- titanic_train %>% 
  ggplot(aes(Sex)) +
  geom_histogram(stat="count")

GA3 <- titanic_train %>%
  ggplot(aes(sample = Age)) + 
  geom_qq(dparams=params) + 
  geom_abline()
GA3

GA4 <- titanic_train %>% 
  ggplot(aes(Survived)) + 
  geom_bar(position=position_dodge())

GA4 <- titanic_train %>% 
  ggplot(aes(Survived, fill=Sex)) + 
  geom_bar(position = position_dodge())
GA4

GA5 <- titanic_train %>%
  filter(Survived=="1")%>%
  ggplot(aes(Age)) +
  geom_density(aes(y=..count..), alpha=0.2)

GA5 <- titanic_train %>%
  ggplot(aes(Age, color=Survived)) +
  geom_density(aes(y=..count..), alpha=0.2)

GA5 <- ggplot(titanic_train, aes(Age, fill = Survived, colour = Survived)) +
  geom_density(aes(y=..count..), alpha = 0.2, position="stack")

GA5 <- titanic %>%
  ggplot(aes(Age, fill=Survived)) + 
  geom_density(aes(y=..count..), alpha = 0.2)
GA5

GA6 <- titanic %>%
  ggplot(aes(Survived, Fare)) + 
  scale_y_continuous(trans="log2") + 
  geom_jitter(width = 0.1, alpha = 0.2)+
  geom_boxplot(aes(group=Survived))
GA6

GA7a <- titanic %>%
  ggplot(aes(Pclass, fill=Survived))+
  geom_bar()

GA7b <- titanic %>%
  ggplot(aes(Pclass, fill=Survived))+
  geom_bar(position=position_fill())

GA7c <- titanic %>%
  ggplot(aes(Survived, fill=Pclass))+
  geom_bar(position=position_fill())

GA8 <- titanic %>%
  ggplot(aes(Age, fill=Survived)) +
  facet_wrap(Sex ~ Pclass) +
  geom_density(aes(y=..count..))
GA8

############## star exercises ################
library(tidyverse)
library(dslabs)
data(stars)
options(digits = 3)   # report 3 significant digits
#update.packages() 

#Q1
mean(stars$magnitude)
sd(stars$magnitude)

#Q2
Q2 <- stars %>%
  ggplot(aes(magnitude)) +
  geom_density()

#Q3
Q3 <- stars %>%
  ggplot(aes(temp)) + 
  geom_density(aes(y=..count..))

#Q4
Q4 <- stars %>%
  ggplot(aes(temp, magnitude)) +
  geom_point() + 
  stat_smooth()

#Q5
Q5 <- stars %>%
  ggplot(aes(temp, magnitude)) + 
  geom_point() + 
  scale_y_reverse() + 
  scale_x_continuous(trans="log10") 

#Q6
Q6 <- stars %>%
  subset(temp<5000) %>%
  ggplot(aes(temp, magnitude, label=star)) + 
  geom_point() + 
  geom_text_repel() +
  scale_y_reverse() + 
  scale_x_continuous(trans="log10") 

Q6a <- stars %>%
  #subset(temp>5000) %>%
  ggplot(aes(temp, magnitude)) + 
  geom_point() + 
  geom_label(filter(stars$star=="Sun"), aes(label=star)) +
  scale_y_reverse() + 
  scale_x_continuous(trans="log10") 

#Q8
#label specific points
Q8 <- stars %>%                      
  ggplot(aes(temp, magnitude)) + 
  geom_point() + 
  geom_label(
    #data=stars %>% filter(temp>5500 & temp<6000), 
    data=stars %>% filter(star=="Sun"), 
    aes(label=star)) +
  scale_y_reverse() + 
  scale_x_continuous(trans="log10") 

#Q9
Q9 <- stars %>%
  #subset(type!="O") %>% #check the colour of O
  ggplot(aes(temp, magnitude, colour=type)) + 
  geom_point() + 
  scale_y_reverse() + 
  scale_x_continuous(trans="log10") 

#Q9c find the Type with higest temperature
Q9c <- stars %>%
  filter(temp>25000) %>%
  ggplot(aes(temp, magnitude, color=type)) + 
  geom_point() + 
  scale_y_reverse() + 
  scale_x_continuous(trans="log10") 

########## climate change exercises #########
library(tidyverse)
library(dslabs)
data(temp_carbon)
data(greenhouse_gases)
data(historic_co2)

install.packages("dslabs")#update dslabs packages
update.packages() #Or just update all packages

#check the record to confirm the answer
Q1 <- temp_carbon %>%
  filter(year=="2018")

#my favorite out of the solutions
Q2 <- temp_carbon %>%
  filter(!is.na(carbon_emissions)) %>%
  select(year) %>%
  max()

#do the same for temperature
Q3 <- temp_carbon %>%
  filter(!is.na(temp_anomaly)) %>%
  .$year %>% #another way to pipe into 'year'
  min()

#filter out lowest and highest in order to compare
Q3b <- temp_carbon %>%
  subset(year=="1880" | year=="2018")

#Q4
p <- temp_carbon %>%
  filter(!is.na(temp_anomaly)) %>%
  ggplot(aes(year, temp_anomaly)) +
  geom_line()

p <- p + geom_hline(aes(yintercept = 0), col = "blue")

p + ylab("Temperature anomaly (degrees C)") +
  ggtitle("Temperature anomaly relative to 20th century mean, 1880-2018") +
  geom_text(aes(x = 2000, y = 0.05, label = "20th century mean"), col = "blue")

#online research https://stackoverflow.com/questions/2564258/plot-two-graphs-in-same-plot-in-r
#redmode had best answer
#
#Add extra layers on y-axis to show multi lines
Q7 <- temp_carbon %>%
  filter(!is.na(temp_anomaly)) %>%
  ggplot(aes(year)) +
  geom_line(aes(y=temp_anomaly, col="global")) +
  geom_line(aes(y=land_anomaly, col="land")) +
  geom_line(aes(y=ocean_anomaly, col="ocean"))

Q7 <- Q7 + geom_hline(aes(yintercept = 0), col = "blue")

Q7 + ylab("Temperature anomaly (degrees C)") +
  ggtitle("Temperature anomaly relative to 20th century mean, 1880-2018") +
  geom_text(aes(x = 2000, y = 0.05, label = "20th century mean"), col = "blue")
