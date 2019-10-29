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

########## Slope Charts ##########
Textbook link
This video corresponds to the textbook section on plots for two variables.
[https://rafalab.github.io/dsbook/data-visualization-principles.html#plots-for-two-variables]

Key points
Bland-Altman plot - Consider using a slope chart or Bland-Altman plot when comparing one variable at two different time points, especially for a small number of observations.
Slope charts - use angle to encode change. Use geom_line to create slope charts. It is useful when comparing a small number of observations.
The Bland-Altman plot (Tukey mean difference plot, MA plot) graphs the difference between conditions on the y-axis and the mean between conditions on the x-axis. It is more appropriate for large numbers of observations than slope charts.

Code: Slope chart
library(tidyverse)
library(dslabs)
data(gapminder)
west <- c("Western Europe", "Northern Europe", "Southern Europe", "Northern America", "Australia and New Zealand")
dat <- gapminder %>%
    filter(year %in% c(2010, 2015) & region %in% west & !is.na(life_expectancy) & population > 10^7)
dat %>%
    mutate(location = ifelse(year == 2010, 1, 2),
                 location = ifelse(year == 2015 & country %in% c("United Kingdom", "Portugal"), location + 0.22, location),
                 hjust = ifelse(year == 2010, 1, 0)) %>%
    mutate(year = as.factor(year)) %>%
    ggplot(aes(year, life_expectancy, group = country)) +
    geom_line(aes(color = country), show.legend = FALSE) +
    geom_text(aes(x = location, label = country, hjust = hjust), show.legend = FALSE) +
    xlab("") +
    ylab("Life Expectancy") 
Code: Bland-Altman plot
library(ggrepel)
dat %>%
    mutate(year = paste0("life_expectancy_", year)) %>%
    select(country, year, life_expectancy) %>% spread(year, life_expectancy) %>%
    mutate(average = (life_expectancy_2015 + life_expectancy_2010)/2,
                difference = life_expectancy_2015 - life_expectancy_2010) %>%
    ggplot(aes(average, difference, label = country)) +
    geom_point() +
    geom_text_repel() +
    geom_abline(lty = 2) +
    xlab("Average of 2010 and 2015") +
    ylab("Difference between 2015 and 2010")

########## Encoding a third variable ##########
Textbook link
This video corresponds to the textbook section on encoding a third variable.
[https://rafalab.github.io/dsbook/data-visualization-principles.html#encoding-a-third-variable]

Key points
Encode a categorical third variable on a scatterplot using color hue or shape. Use the shape argument to control shape.
Encode a continuous third variable on a using color intensity or size.


########## case study: vaccines #########
Textbook link
This video corresponds to the textbook case study on vaccines. Information on color palettes can be found in the textbook section on encoding a third variable.

Key points
Vaccines save millions of lives, but misinformation has led some to question the safety of vaccines. The data support vaccines as safe and effective. We visualize data about measles incidence in order to demonstrate the impact of vaccination programs on disease rate.
The RColorBrewer package offers several color palettes. Sequential color palettes are best suited for data that span from high to low. Diverging color palettes are best suited for data that are centered and diverge towards high or low values.
The geom_tile geometry creates a grid of colored tiles.
Position and length are stronger cues than color for numeric values, but color can be appropriate sometimes.
Code: Tile plot of measles rate by year and state
# import data and inspect
library(tidyverse)
library(dslabs)
data(us_contagious_diseases)
str(us_contagious_diseases)
# assign dat to the per 10,000 rate of measles, removing Alaska and Hawaii and adjusting for weeks reporting
the_disease <- "Measles"
dat <- us_contagious_diseases %>%
    filter(!state %in% c("Hawaii", "Alaska") & disease == the_disease) %>%
    mutate(rate = count / population * 10000 * 52/weeks_reporting) %>%
    mutate(state = reorder(state, rate))
# plot disease rates per year in California
dat %>% filter(state == "California" & !is.na(rate)) %>%
    ggplot(aes(year, rate)) +
    geom_line() +
    ylab("Cases per 10,000") +
    geom_vline(xintercept=1963, col = "blue")
# tile plot of disease rate by state and year
dat %>% ggplot(aes(year, state, fill=rate)) +
    geom_tile(color = "grey50") +
    scale_x_continuous(expand = c(0,0)) +
    scale_fill_gradientn(colors = RColorBrewer::brewer.pal(9, "Reds"), trans = "sqrt") +
    geom_vline(xintercept = 1963, col = "blue") +
    theme_minimal() + theme(panel.grid = element_blank()) +
    ggtitle(the_disease) +
    ylab("") +
    xlab("")
Code: Line plot of measles rate by year and state
# compute US average measles rate by year
avg <- us_contagious_diseases %>%
    filter(disease == the_disease) %>% group_by(year) %>%
    summarize(us_rate = sum(count, na.rm = TRUE)/sum(population, na.rm = TRUE)*10000)
# make line plot of measles rate by year by state
dat %>%
    filter(!is.na(rate)) %>%
    ggplot() +
    geom_line(aes(year, rate, group = state), color = "grey50", 
        show.legend = FALSE, alpha = 0.2, size = 1) +
    geom_line(mapping = aes(year, us_rate), data = avg, size = 1, col = "black") +
    scale_y_continuous(trans = "sqrt", breaks = c(5, 25, 125, 300)) +
    ggtitle("Cases per 10,000 by state") +
    xlab("") +
    ylab("") +
    geom_text(data = data.frame(x = 1955, y = 50),
        mapping = aes(x, y, label = "US average"), color = "black") +
    geom_vline(xintercept = 1963, col = "blue")

########## Avoid Pseudo and Gratuitous 3D Plots ##########
Textbook link
This video corresponds to the textbook section on avoiding gratuitous 3D plots.
[https://rafalab.github.io/dsbook/data-visualization-principles.html#avoid-pseudo-three-dimensional-plots]

Key point
In general, pseudo-3D plots and gratuitous 3D plots only add confusion. Use regular 2D plots instead.

########## Avoid Too Many Significant Digits ##########
Textbook link
This video corresponds to the textbook section on avoiding too many significant digits.
[https://rafalab.github.io/dsbook/data-visualization-principles.html#avoid-too-many-significant-digits]

Key points
In tables, avoid using too many significant digits. Too many digits can distract from the meaning of your data.
Reduce the number of significant digits globally by setting an option. For example, options(digits = 3) will cause all future computations that session to have 3 significant digits.
Reduce the number of digits locally using round or signif.

########## Exercise 1: Tile plot - measles and smallpox ##########
Modify the tile plot to show the rate of smallpox cases instead of measles cases.
Exclude years in which cases were reported in fewer than 10 weeks from the plot.

library(dplyr)
library(ggplot2)
library(RColorBrewer)
library(dslabs)
data(us_contagious_diseases)

the_disease = "Smallpox"
dat <- us_contagious_diseases %>% 
   filter(!state%in%c("Hawaii","Alaska") & disease == the_disease & weeks_reporting > 9) %>% 
   mutate(rate = count / population * 10000) %>% 
   mutate(state = reorder(state, rate))

dat %>% ggplot(aes(year, state, fill = rate)) + 
  geom_tile(color = "grey50") + 
  scale_x_continuous(expand=c(0,0)) + 
  scale_fill_gradientn(colors = brewer.pal(9, "Reds"), trans = "sqrt") + 
  theme_minimal() + 
  theme(panel.grid = element_blank()) + 
  ggtitle(the_disease) + 
  ylab("") + 
  xlab("")
 
########## Exercise 2. Time series plot - measles and smallpox ##########
Modify the sample code for the time series plot to plot data for smallpox instead of for measles.
Once again, restrict the plot to years in which cases were reported in at least 10 weeks.

library(dplyr)
library(ggplot2)
library(dslabs)
library(RColorBrewer)
data(us_contagious_diseases)

the_disease = "Smallpox"
dat <- us_contagious_diseases %>%
   filter(!state%in%c("Hawaii","Alaska") & disease == the_disease & weeks_reporting > 9) %>%
   mutate(rate = count / population * 10000) %>%
   mutate(state = reorder(state, rate))

avg <- us_contagious_diseases %>%
  filter(disease==the_disease) %>% group_by(year) %>%
  summarize(us_rate = sum(count, na.rm=TRUE)/sum(population, na.rm=TRUE)*10000)

dat %>% ggplot() +
  geom_line(aes(year, rate, group = state),  color = "grey50", 
            show.legend = FALSE, alpha = 0.2, size = 1) +
  geom_line(mapping = aes(year, us_rate),  data = avg, size = 1, color = "black") +
  scale_y_continuous(trans = "sqrt", breaks = c(5,25,125,300)) + 
  ggtitle("Cases per 10,000 by state") + 
  xlab("") + 
  ylab("") +
  geom_text(data = data.frame(x=1955, y=50), mapping = aes(x, y, label="US average"), color="black") + 
  geom_vline(xintercept=1963, col = "blue")
  

########## Exercise 3: Time series plot - all diseases in California ##########
For the state of California, make a time series plot showing rates for all diseases.
Include only years with 10 or more weeks reporting.
Use a different color for each disease.
Include your aes function inside of ggplot rather than inside your geom layer.

library(dplyr)
library(ggplot2)
library(dslabs)
library(RColorBrewer)
data(us_contagious_diseases)

us_contagious_diseases %>% filter(state=="California" & weeks_reporting>=10) %>% 
  group_by(year, disease) %>%
  summarize(rate = sum(count)/sum(population)*10000) %>%
  ggplot(aes(year, rate, color=disease)) + 
  geom_line()
  

########## Exercise 4: Time series plot - all diseases in the United States ##########
Compute the US rate by using summarize to sum over states. Call the variable rate.
  The US rate for each disease will be the total number of cases divided by the total population.
  Remember to convert to cases per 10,000.
You will need to filter for !is.na(population) to get all the data.
Plot each disease in a different color.

library(dplyr)
library(ggplot2)
library(dslabs)
library(RColorBrewer)
data(us_contagious_diseases)

#count(us_contagious_diseases)
#head(us_contagious_diseases)
 
 us_contagious_diseases %>% 
  group_by(year, disease) %>%
  filter(!is.na(population)) %>%
  summarise(rate = sum(count)/sum(population)*10000) %>%
  ggplot(aes(year, rate, color=disease)) +
  geom_line()










