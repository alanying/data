########## Case Study: Trends in World Health and Economics ############
Textbook link
This video corresponds to the textbook section introducing the case study on new insights in poverty.
[https://rafalab.github.io/dsbook/gapminder.html#case-study-new-insights-on-poverty]

More about Gapminder
The original Gapminder TED talks are available and we encourage you to watch them.

The Best Stats You've Ever Seen [https://www.ted.com/talks/hans_rosling_shows_the_best_stats_you_ve_ever_seen?language=en]
New Insights on Poverty [https://www.ted.com/talks/hans_rosling_reveals_new_insights_on_poverty?language=en]
You can also find more information and raw data (in addition to what we analyze in class) at https://www.gapminder.org/.

Key points
Data visualization can be used to dispel common myths and educate the public and contradict sensationalist or outdated claims and stories.
We will use real data to answer the following questions about world health and economics:
Is it still fair to consider the world as divided into the West and the developing world?
Has income inequality across countries worsened over the last 40 years?

########## Gapminder dataset ##########
Key points
A selection of world health and economics statistics from the Gapminder project can be found in the dslabs package as data(gapminder).
Most people have misconceptions about world health and economics, which can be addressed by considering real data.
Code
# load and inspect gapminder data
library(dslabs)
data(gapminder)
head(gapminder)
# compare infant mortality in Sri Lanka and Turkey
gapminder %>%
    filter(year == 2015 & country %in% c("Sri Lanka", "Turkey")) %>%
    select(country, infant_mortality)
    
########## Life Expectancy and Fertility Rates ##########
Textbook link
This video corresponds to the textbook section on Gapminder scatterplots.
[https://rafalab.github.io/dsbook/gapminder.html#scatterplots]

Key points
A prevalent worldview is that the world is divided into two groups of countries:
Western world: high life expectancy, low fertility rate
Developing world: lower life expectancy, higher fertility rate
Gapminder data can be used to evaluate the validity of this view.
A scatterplot of life expectancy versus fertility rate in 1962 suggests that this viewpoint was grounded in reality 50 years ago. Is it still the case today?
Code
# basic scatterplot of life expectancy versus fertility
ds_theme_set()    # set plot theme
filter(gapminder, year == 1962) %>%
    ggplot(aes(fertility, life_expectancy)) +
    geom_point()
# add color as continent
filter(gapminder, year == 1962) %>%
    ggplot(aes(fertility, life_expectancy, color = continent)) +
    geom_point() 
    
########## Faceting #########
Textbook link
This video corresponds to the textbook section on faceting.
[https://rafalab.github.io/dsbook/gapminder.html#faceting]

Key points
Faceting makes multiple side-by-side plots stratified by some variable. This is a way to ease comparisons.
The facet_grid function allows faceting by up to two variables, with rows faceted by one variable and columns faceted by the other variable. To facet by only one variable, use the dot operator as the other variable.
The facet_wrap function facets by one variable and automatically wraps the series of plots so they have readable dimensions.
Faceting keeps the axes fixed across all plots, easing comparisons between plots.
The data suggest that the developing versus Western world view no longer makes sense in 2012.
Code
# facet by continent and year
filter(gapminder, year %in% c(1962, 2012)) %>%
    ggplot(aes(fertility, life_expectancy, col = continent)) +
    geom_point() +
    facet_grid(continent ~ year)
# facet by year only
filter(gapminder, year %in% c(1962, 2012)) %>%
    ggplot(aes(fertility, life_expectancy, col = continent)) +
    geom_point() +
    facet_grid(. ~ year)
# facet by year, plots wrapped onto multiple rows
years <- c(1962, 1980, 1990, 2000, 2012)
continents <- c("Europe", "Asia")
gapminder %>%
    filter(year %in% years & continent %in% continents) %>%
    ggplot(aes(fertility, life_expectancy, col = continent)) +
    geom_point() +
    facet_wrap(~year)

######### Time Series Plots ##########
Textbook link
This video corresponds to the textbook section on time series plots.
[https://rafalab.github.io/dsbook/gapminder.html#time-series-plots]

Key points
Time series plots have time on the x-axis and a variable of interest on the y-axis.
The geom_line geometry connects adjacent data points to form a continuous line. A line plot is appropriate when points are regularly spaced, densely packed and from a single data series.
 You can plot multiple lines on the same graph. Remember to group or color by a variable so that the lines are plotted independently.
Labeling is usually preferred over legends. However, legends are easier to make and appear by default. Add a label with geom_text, specifying the coordinates where the label should appear on the graph.

Code: Single time series
# scatterplot of US fertility by year
gapminder %>%
    filter(country == "United States") %>%
    ggplot(aes(year, fertility)) +
    geom_point()

# line plot of US fertility by year
gapminder %>%
    filter(country == "United States") %>%
    ggplot(aes(year, fertility)) +
    geom_line()

Code: Multiple time series
# line plot fertility time series for two countries- only one line (incorrect)
countries <- c("South Korea", "Germany")
gapminder %>% filter(country %in% countries) %>%
    ggplot(aes(year, fertility)) +
    geom_line()

# line plot fertility time series for two countries - one line per country
gapminder %>% filter(country %in% countries) %>%
    ggplot(aes(year, fertility, group = country)) +
    geom_line()

# fertility time series for two countries - lines colored by country
gapminder %>% filter(country %in% countries) %>%
    ggplot(aes(year, fertility, col = country)) +
    geom_line()

Code: Adding text labels to a plot
# life expectancy time series - lines colored by country and labeled, no legend
labels <- data.frame(country = countries, x = c(1975, 1965), y = c(60, 72))
gapminder %>% filter(country %in% countries) %>%
    ggplot(aes(year, life_expectancy, col = country)) +
    geom_line() +
    geom_text(data = labels, aes(x, y, label = country), size = 5) +
    theme(legend.position = "none")


########## Transformation ###########
Textbook link
This video corresponds to the textbook section on transformations and the textbook section on visualizing multimodal distributions.
[https://rafalab.github.io/dsbook/gapminder.html#data-transformations]
[https://rafalab.github.io/dsbook/gapminder.html#visualizing-multimodal-distributions]

Key points
We use GDP data to compute income in US dollars per day, adjusted for inflation.
Log transformations convert multiplicative changes into additive changes.
Common transformations are the log base 2 transformation and the log base 10 transformation. The choice of base depends on the range of the data. The natural log is not recommended for visualization because it is difficult to interpret.
The mode of a distribution is the value with the highest frequency. The mode of a normal distribution is the average. A distribution can have multiple local modes.
There are two ways to use log transformations in plots: transform the data before plotting or transform the axes of the plot. Log scales have the advantage of showing the original values as axis labels, while log transformed values ease interpretation of intermediate values between labels.
Scale the x-axis using scale_x_continuous or scale_x_log10 layers in ggplot2. Similar functions exist for the y-axis.
In 1970, income distribution is bimodal, consistent with the dichotomous Western versus developing worldview.

Code
# add dollars per day variable
gapminder <- gapminder %>%
    mutate(dollars_per_day = gdp/population/365)

# histogram of dollars per day
past_year <- 1970
gapminder %>%
    filter(year == past_year & !is.na(gdp)) %>%
    ggplot(aes(dollars_per_day)) +
    geom_histogram(binwidth = 1, color = "black")

# repeat histogram with log2 scaled data
gapminder %>%
    filter(year == past_year & !is.na(gdp)) %>%
    ggplot(aes(log2(dollars_per_day))) +
    geom_histogram(binwidth = 1, color = "black")

# repeat histogram with log2 scaled x-axis
gapminder %>%
    filter(year == past_year & !is.na(gdp)) %>%
    ggplot(aes(dollars_per_day)) +
    geom_histogram(binwidth = 1, color = "black") +
    scale_x_continuous(trans = "log2")


########### Stratify and Boxplot ###########
Textbook link
This video corresponds to the textbook section on comparing multiple distributions with boxplots. Note that many boxplots from the video are instead dot plots in the textbook and that a different boxplot is constructed in the textbook. Also read that section to see an example of grouping factors with the case_when function.
[https://rafalab.github.io/dsbook/gapminder.html#comparing-multiple-distributions-with-boxplots-and-ridge-plots]

Key points
Make boxplots stratified by a categorical variable using the geom_boxplot geometry.
Rotate axis labels by changing the theme through element_text. You can change the angle and justification of the text labels.
Consider ordering your factors by a meaningful value with the reorder function, which changes the order of factor levels based on a related numeric vector. This is a way to ease comparisons.
Show the data by adding data points to the boxplot with a geom_point layer. This adds information beyond the five-number summary to your plot, but too many data points it can obfuscate your message.
Code: Boxplot of GDP by region
# add dollars per day variable
gapminder <- gapminder %>%
    mutate(dollars_per_day = gdp/population/365)
# number of regions
length(levels(gapminder$region))
# boxplot of GDP by region in 1970
past_year <- 1970
p <- gapminder %>%
    filter(year == past_year & !is.na(gdp)) %>%
    ggplot(aes(region, dollars_per_day))
p + geom_boxplot()
# rotate names on x-axis
p + geom_boxplot() +
    theme(axis.text.x = element_text(angle = 90, hjust = 1))
Code: The reorder function
# by default, factor order is alphabetical
fac <- factor(c("Asia", "Asia", "West", "West", "West"))
levels(fac)

# reorder factor by the category means
value <- c(10, 11, 12, 6, 4)
fac <- reorder(fac, value, FUN = mean)
levels(fac)
Code: Enhanced boxplot ordered by median income, scaled, and showing data
# reorder by median income and color by continent
p <- gapminder %>%
    filter(year == past_year & !is.na(gdp)) %>%
    mutate(region = reorder(region, dollars_per_day, FUN = median)) %>%    # reorder
    ggplot(aes(region, dollars_per_day, fill = continent)) +    # color by continent
    geom_boxplot() +
    theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
    xlab("")

# log2 scale y-axis
p + scale_y_continuous(trans = "log2")
# add data points
p + scale_y_continuous(trans = "log2") + geom_point(show.legend = FALSE)


########### comparing distrubition ##########
Textbook link
This video corresponds to the textbook section on 1970 versus 2010 income distributions. Note that the boxplots are slightly different: the group variable in those plots was defined in section 10.7.1.
[https://rafalab.github.io/dsbook/gapminder.html#example-1970-versus-2010-income-distributions]

Key points
Use intersect to find the overlap between two vectors.
To make boxplots where grouped variables are adjacaent, color the boxplot by a factor instead of faceting by that factor. This is a way to ease comparisons.
The data suggest that the income gap between rich and poor countries has narrowed, not expanded.
Code: Histogram of income in West versus developing world, 1970 and 2010
# add dollars per day variable and define past year
gapminder <- gapminder %>%
    mutate(dollars_per_day = gdp/population/365)
past_year <- 1970
# define Western countries
west <- c("Western Europe", "Northern Europe", "Southern Europe", "Northern America", "Australia and New Zealand")

# facet by West vs devloping
gapminder %>%
    filter(year == past_year & !is.na(gdp)) %>%
    mutate(group = ifelse(region %in% west, "West", "Developing")) %>%
    ggplot(aes(dollars_per_day)) +
    geom_histogram(binwidth = 1, color = "black") +
    scale_x_continuous(trans = "log2") +
    facet_grid(. ~ group)
# facet by West/developing and year
present_year <- 2010
gapminder %>%
    filter(year %in% c(past_year, present_year) & !is.na(gdp)) %>%
    mutate(group = ifelse(region %in% west, "West", "Developing")) %>%
    ggplot(aes(dollars_per_day)) +
    geom_histogram(binwidth = 1, color = "black") +
    scale_x_continuous(trans = "log2") +
    facet_grid(year ~ group)
Code: Income distribution of West versus developing world, only countries with data 
# define countries that have data available in both years
country_list_1 <- gapminder %>%
    filter(year == past_year & !is.na(dollars_per_day)) %>% .$country
country_list_2 <- gapminder %>%
    filter(year == present_year & !is.na(dollars_per_day)) %>% .$country
country_list <- intersect(country_list_1, country_list_2)
# make histogram including only countries with data available in both years
gapminder %>%
    filter(year %in% c(past_year, present_year) & country %in% country_list) %>%    # keep only selected countries
    mutate(group = ifelse(region %in% west, "West", "Developing")) %>%
    ggplot(aes(dollars_per_day)) +
    geom_histogram(binwidth = 1, color = "black") +
    scale_x_continuous(trans = "log2") +
    facet_grid(year ~ group)
Code: Boxplots of income in West versus developing world, 1970 and 2010
p <- gapminder %>%
    filter(year %in% c(past_year, present_year) & country %in% country_list) %>%
    mutate(region = reorder(region, dollars_per_day, FUN = median)) %>%
    ggplot() +
    theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
    xlab("") + scale_y_continuous(trans = "log2")
p + geom_boxplot(aes(region, dollars_per_day, fill = continent)) +
    facet_grid(year ~ .)
# arrange matching boxplots next to each other, colored by year
p + geom_boxplot(aes(region, dollars_per_day, fill = factor(year)))


########## Density Plots ###########

Textbook link
This video corresponds to the following sections:

The end of the textbook section on 1970 versus 2010 income distributions [https://rafalab.github.io/dsbook/gapminder.html#example-1970-versus-2010-income-distributions]
Textbook section on accessing computed variables [https://rafalab.github.io/dsbook/gapminder.html#accessing-computed-variables]
Textbook section on weighted densities [https://rafalab.github.io/dsbook/gapminder.html#weighted-densities]

Key points
Change the y-axis of density plots to variable counts using ..count.. as the y argument.
The case_when function defines a factor whose levels are defined by a variety of logical operations to group data.
Plot stacked density plots using position="stack".
Define a weight aesthetic mapping to change the relative weights of density plots - for example, this allows weighting of plots by population rather than number of countries.
Code: Faceted smooth density plots
# see the code below the previous video for variable definitions

# smooth density plots - area under each curve adds to 1
gapminder %>%
    filter(year == past_year & country %in% country_list) %>%
    mutate(group = ifelse(region %in% west, "West", "Developing")) %>% group_by(group) %>%
    summarize(n = n()) %>% knitr::kable()
# smooth density plots - variable counts on y-axis
p <- gapminder %>%
    filter(year == past_year & country %in% country_list) %>%
    mutate(group = ifelse(region %in% west, "West", "Developing")) %>%
    ggplot(aes(dollars_per_day, y = ..count.., fill = group)) +
    scale_x_continuous(trans = "log2")
p + geom_density(alpha = 0.2, bw = 0.75) + facet_grid(year ~ .)
Code: Add new region groups with case_when
# add group as a factor, grouping regions
gapminder <- gapminder %>%
    mutate(group = case_when(
        .$region %in% west ~ "West",
        .$region %in% c("Eastern Asia", "South-Eastern Asia") ~ "East Asia",
        .$region %in% c("Caribbean", "Central America", "South America") ~ "Latin America",
        .$continent == "Africa" & .$region != "Northern Africa" ~ "Sub-Saharan Africa",
        TRUE ~ "Others"))
# reorder factor levels
gapminder <- gapminder %>%
    mutate(group = factor(group, levels = c("Others", "Latin America", "East Asia", "Sub-Saharan Africa", "West")))
Code: Stacked density plot
# note you must redefine p with the new gapminder object first
p <- gapminder %>%
  filter(year %in% c(past_year, present_year) & country %in% country_list) %>%
    ggplot(aes(dollars_per_day, fill = group)) +
    scale_x_continuous(trans = "log2")
# stacked density plot
p + geom_density(alpha = 0.2, bw = 0.75, position = "stack") +
    facet_grid(year ~ .)
Code: Weighted stacked density plot
# weighted stacked density plot
gapminder %>%
    filter(year %in% c(past_year, present_year) & country %in% country_list) %>%
    group_by(year) %>%
    mutate(weight = population/sum(population*2)) %>%
    ungroup() %>%
    ggplot(aes(dollars_per_day, fill = group, weight = weight)) +
    scale_x_continuous(trans = "log2") +
    geom_density(alpha = 0.2, bw = 0.75, position = "stack") + facet_grid(year ~ .)



########## Ecological Fallacy ############
Textbook link
This video corresponds to the textbook section on the ecological fallacy.
[https://rafalab.github.io/dsbook/gapminder.html#the-ecological-fallacy-and-importance-of-showing-the-data]

Key points
The breaks argument allows us to set the location of the axis labels and tick marks.
The logistic or logit transformation is defined as f(p)=log(p/1−p) , or the log of odds. This scale is useful for highlighting differences near 0 or near 1 and converts fold changes into constant increases.
The ecological fallacy is assuming that conclusions made from the average of a group apply to all members of that group.
Code
# define gapminder
library(tidyverse)
library(dslabs)
data(gapminder)
# add additional cases
gapminder <- gapminder %>%
    mutate(group = case_when(
        .$region %in% west ~ "The West",
        .$region %in% "Northern Africa" ~ "Northern Africa",
        .$region %in% c("Eastern Asia", "South-Eastern Asia") ~ "East Asia",
        .$region == "Southern Asia" ~ "Southern Asia",
        .$region %in% c("Central America", "South America", "Caribbean") ~ "Latin America",
        .$continent == "Africa" & .$region != "Northern Africa" ~ "Sub-Saharan Africa",
        .$region %in% c("Melanesia", "Micronesia", "Polynesia") ~ "Pacific Islands"))
# define a data frame with group average income and average infant survival rate
surv_income <- gapminder %>%
    filter(year %in% present_year & !is.na(gdp) & !is.na(infant_mortality) & !is.na(group)) %>%
    group_by(group) %>%
    summarize(income = sum(gdp)/sum(population)/365,
                        infant_survival_rate = 1 - sum(infant_mortality/1000*population)/sum(population))
surv_income %>% arrange(income)
# plot infant survival versus income, with transformed axes
surv_income %>% ggplot(aes(income, infant_survival_rate, label = group, color = group)) +
    scale_x_continuous(trans = "log2", limit = c(0.25, 150)) +
    scale_y_continuous(trans = "logit", limit = c(0.875, .9981),
                                       breaks = c(.85, .90, .95, .99, .995, .998)) +
    geom_label(size = 3, show.legend = FALSE) 


########### exercise ##########
########## Exercise 1. Life expectancy vs fertility - part 1 ##########
The Gapminder Foundation (www.gapminder.org) is a non-profit organization based in Sweden that promotes global development through the use of statistics that can help reduce misconceptions about global development.

Using ggplot and the points layer, create a scatter plot of life expectancy versus fertility for the African continent in 2012.
Remember that you can use the R console to explore the gapminder dataset to figure out the names of the columns in the dataframe.
In this exercise we provide parts of code to get you going. You need to fill out what is missing. But note that going forward, in the next exercises, you will be required to write most of the code.


