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
