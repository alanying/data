####################################################################
############################## Part 1 ##############################
####################################################################
Encoding Data Using Visual Cues - humans prefer Position & Length
When to include zero - when showing length, not when showing position
Do Not Distort Quantities - use area, not radius
Order by a Meaningful Value - not alphabetical, use Reorder function to help

########### Intro ##########
Textbook link
This video corresponds to the textbook chapter introduction on data visualization principles.
[https://rafalab.github.io/dsbook/data-visualization-principles.html]

Key points
We aim to provide some general guidelines for effective data visualization.
We show examples of plot styles to avoid, discuss how to improve them, and use these examples to explain research-based principles for effective visualization.
When choosing a visualization approach, keep your goal and audience in mind.

########### Encoding Data Using Visual Cues ##########
Textbook links
This video corresponds to the textbook section on encoding data using visual cues. [https://rafalab.github.io/dsbook/data-visualization-principles.html#encoding-data-using-visual-cues]
You can learn more about barplots in the textbook section on barplots. [https://rafalab.github.io/dsbook/distributions.html#barplots]

Key points
Visual cues for encoding data include position, length, angle, area, brightness and color hue.
Position and length are the preferred way to display quantities, followed by angles, which are preferred over area. Brightness and color are even harder to quantify but can sometimes be useful.
Pie charts represent visual cues as both angles and area, while donut charts use only area. Humans are not good at visually quantifying angles and are even worse at quantifying area. Therefore pie and donut charts should be avoided - use a bar plot instead. If you must make a pie chart, include percentages as labels.
Bar plots represent visual cues as position and length. Humans are good at visually quantifying linear measures, making bar plots a strong alternative to pie or donut charts.

In order of what's better for humans:
Position & Length
Quantities
Angles
Area (use lebal % on Pie chart if we must)
Brightness & Colour (sometimes useful with 2+ dimensions)

######### When to include zero ##########
Textbook link
This video corresponds to the textbook section on knowing when to include 0.
[https://rafalab.github.io/dsbook/data-visualization-principles.html#know-when-to-include-0]

Key points
When using bar plots, always start at 0. It is deceptive not to start at 0 because bar plots imply length is proportional to the quantity displayed. Cutting off the y-axis can make differences look bigger than they actually are.
When using position rather than length, it is not necessary to include 0 (scatterplot, dot plot, boxplot).

########## Do Not Distort Quantities ##########
Textbook link
This video corresponds to the textbook section on not distorting quantities.
[https://rafalab.github.io/dsbook/data-visualization-principles.html#do-not-distort-quantities]

Key points
Make sure your visualizations encode the correct quantities.
For example, if you are using a plot that relies on circle area, make sure the area (rather than the radius) is proportional to the quantity.

########## Order by a Meaningful Value ##########
Textbook link
This video corresponds to the textbook section on ordering categories by a meaningful value.
[https://rafalab.github.io/dsbook/data-visualization-principles.html#order-categories-by-a-meaningful-value]

Key points
It is easiest to visually extract information from a plot when categories are ordered by a meaningful value. The exact value on which to order will depend on your data and the message you wish to convey with your plot.
The default ordering for categories is alphabetical if the categories are strings or by factor level if factors. However, we rarely want alphabetical order.

####################################################################
############################## Part 2 ##############################
####################################################################
Show the Data - show the distribution, not just dots as they might overlap
Use Common Axes - bar plot good for 1 number but not distribution; facet_grid to easily compare 2 distributions
Consider Transformations - different plot for different purposes e.g. boxplot is better than barplot when compare population
Compared Visual Cues Should Be Adjacent - comparison can be right next to each other per value

######### show the data ############
Textbook link
This video corresponds to the textbook section on the principle of showing data.
[https://rafalab.github.io/dsbook/data-visualization-principles.html#show-the-data-1]

Key points
A dynamite plot - a bar graph of group averages with error bars denoting standard errors - provides almost no information about a distribution.
By showing the data, you provide viewers extra information about distributions.
Jitter is adding a small random shift to each point in order to minimize the number of overlapping points. To add jitter, use the  geom_jitter geometry instead of geom_point. (See example below.)
Alpha blending is making points somewhat transparent, helping visualize the density of overlapping points. Add an alpha argument to the geometry.

Code
# dot plot showing the data
heights %>% ggplot(aes(sex, height)) + geom_point()
# jittered, alpha blended point plot
heights %>% ggplot(aes(sex, height)) + geom_jitter(width = 0.1, alpha = 0.2)

########## Ease Comparisons: Use Common Axes ##########
Textbook link
This video corresponds to the textbook section on easing comparisons with common axes and alignment.
[https://rafalab.github.io/dsbook/data-visualization-principles.html#ease-comparisons]

Key points
Ease comparisons by keeping axes the same when comparing data across multiple plots.
Align plots vertically to see horizontal changes. Align plots horizontally to see vertical changes.
Bar plots are useful for showing one number but not useful for showing distributions.

############### Consider Transformations ###############
Textbook link
This video corresponds to the textbook section on considering transformations.
[https://rafalab.github.io/dsbook/data-visualization-principles.html#consider-transformations]

Key points
Use transformations when warranted to ease visual interpretation.
The log transformation is useful for data with multiplicative changes. The logistic transformation is useful for fold changes in odds. The square root transformation is useful for count data.
We learned how to apply transformations earlier in the course.

########## Ease Comparisons: Compared Visual Cues Should Be Adjacent ##########
Textbook link
This video corresponds to the following:
textbook section on compared visual cues being adjacent [https://rafalab.github.io/dsbook/data-visualization-principles.html#visual-cues-to-be-compared-should-be-adjacent]
textbook section on using color [https://rafalab.github.io/dsbook/data-visualization-principles.html#use-color]
textbook section on considering the color blind [https://rafalab.github.io/dsbook/data-visualization-principles.html#think-of-the-color-blind]

Key points
When two groups are to be compared, it is optimal to place them adjacent in the plot.
Use color to encode groups to be compared.
Consider using a color blind friendly palette like the one in this video.
Code
color_blind_friendly_cols <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
p1 <- data.frame(x = 1:8, y = 1:8, col = as.character(1:8)) %>%
    ggplot(aes(x, y, color = col)) +
    geom_point(size = 5)
p1 + scale_color_manual(values = color_blind_friendly_cols)

########## Exercise 1: Customizing plots - watch and learn ########
Redefine the state object so that the levels are re-ordered by rate.
Print the new object state and its levels (using levels) so you can see that the vector is now re-ordered by the levels.

library(dplyr)
library(ggplot2)
library(dslabs)
dat <- us_contagious_diseases %>%
filter(year == 1967 & disease=="Measles" & !is.na(population)) %>% mutate(rate = count / population * 10000 * 52 / weeks_reporting)
state <- dat$state <- reorder(state, rate)
rate <- dat$count/(dat$population/10000)*(52/dat$weeks_reporting)

print(levels(state))

########## Exercise 2: Customizing plots - redefining ##########
customize this plot a little more by creating a rate variable and reordering by that variable instead.
Add a single line of code to the definition of the dat table that uses mutate to reorder the states by the rate variable.
The sample code provided will then create a bar plot using the newly defined dat.

library(dplyr)
library(ggplot2)
library(dslabs)
data(us_contagious_diseases)
dat <- us_contagious_diseases %>% 
  filter(year == 1967 & disease=="Measles" & count>0 & !is.na(population)) %>%
  mutate(rate = count / population * 10000 * 52 / weeks_reporting, state=reorder(state, rate))
dat %>% 
  ggplot(aes(state, rate)) +
  geom_bar(stat="identity") +
  coord_flip()

######### Exercise 4: Making a box plot #########
To further investigate whether moving to the western region is a wise decision, lets make a box plot of murder rates by region, showing all points.
Make a box plot of the murder rates by region.
Order the regions by their median murder rate.
Show all of the points on the box plot.

library(dplyr)
library(ggplot2)
library(dslabs)
data("murders")
murders %>% mutate(rate = total/population*100000, region = reorder(region, rate, FUN=median)) %>%
  ggplot(aes(region, rate)) +
  geom_point() +
  geom_boxplot()

####################################################################
############################## Part 3 ##############################
####################################################################

