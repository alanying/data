Note that you can also load ggplot2 alone using the command library(ggplot2), instead of loading the entire tidyverse
cheat sheet [https://rstudio.com/wp-content/uploads/2015/03/ggplot2-cheatsheet.pdf]

########## graph components ############
Key points
Plots in ggplot2 consist of 3 main components:
Data: The dataset being summarized
Geometry: The type of plot (scatterplot, boxplot, barplot, histogram, qqplot, smooth density, etc.)
Aesthetic mapping: Variables mapped to visual cues, such as x-axis and y-axis values and color

There are additional components:
Scale
Labels, Title, Legend
Theme/Style

########## creating new plot ############
Key points
- You can associate a dataset x with a ggplot object with any of the 3 commands:
  -> ggplot(data = x)
  -> ggplot(x)
  -> x %>% ggplot()
- You can assign a ggplot object to a variable. If the object is not assigned to a variable, it will automatically be displayed.
- You can display a ggplot object assigned to a variable by printing that variable.

Code
library(tidyverse)
library(dslabs)
data(murders)

ggplot(data = murders)

murders %>% ggplot

p <- ggplot(data = murders)
class(p)
print(p)    # this is equivalent to simply typing p

########### Layer ###########
Key points
In ggplot2, graphs are created by adding layers to the ggplot object:
- DATA %>% ggplot() + LAYER_1 + LAYER_2 + ... + LAYER_N
- The geometry layer defines the plot type and takes the format geom_X where X is the plot type.
- Aesthetic mappings describe how properties of the data connect with features of the graph (axis position, color, size, etc.) Define aesthetic mappings with the aes function.
- aes uses variable names from the object component (for example, total rather than murders$total).
- geom_point creates a scatterplot and requires x and y aesthetic mappings. 
- geom_text and geom_label add text to a scatterplot and require x, y, and label aesthetic mappings.
- To determine which aesthetic mappings are required for a geometry, read the help file for that geometry.
- You can add layers with different aesthetic mappings to the same graph.

Code: Adding layers to a plot
library(tidyverse)
library(dslabs)
data(murders)

murders %>% ggplot() +
    geom_point(aes(x = population/10^6, y = total))
# add points layer to predefined ggplot object
p <- ggplot(data = murders)
p + geom_point(aes(population/10^6, total))

# add text layer to scatterplot
p + geom_point(aes(population/10^6, total)) +
    geom_text(aes(population/10^6, total, label = abb))
    
Code: Example of aes behavior
# no error from this call
p_test <- p + geom_text(aes(population/10^6, total, label = abb))

# error - "abb" is not a globally defined variable and cannot be found outside of aes
p_test <- p + geom_text(aes(population/10^6, total), label = abb)

######### tinkering ###########
Key points
- You can modify arguments to geometry functions other than aes and the data. Additional arguments can be found in the documentation for each geometry.
- These arguments are not aesthetic mappings: they affect all data points the same way.
- Global aesthetic mappings apply to all geometries and can be defined when you initially call ggplot. All the geometries added as layers will default to this mapping. Local aesthetic mappings add additional information or override the default mappings.

Code
# change the size of the points
p + geom_point(aes(population/10^6, total), size = 3) +
    geom_text(aes(population/10^6, total, label = abb))
    
# move text labels slightly to the right
p + geom_point(aes(population/10^6, total), size = 3) +
    geom_text(aes(population/10^6, total, label = abb), nudge_x = 1)
    
# simplify code by adding global aesthetic
p <- murders %>% ggplot(aes(population/10^6, total, label = abb))
p + geom_point(size = 3) +
    geom_text(nudge_x = 1.5)
    
# local aesthetics override global aesthetics
p + geom_point(size = 3) +
    geom_text(aes(x = 10, y = 800, label = "Hello there!"))
    

############ Scales, Labels, and Colors ###########    
Key points
- Convert the x-axis to log scale with scale_x_continuous(trans = "log10") or scale_x_log10. Similar functions exist for the y-axis.
- Add axis titles with xlab and ylab functions. Add a plot title with the ggtitle function.
- Add a color mapping that colors points by a variable by defining the col argument within aes. To color all points the same way, define col outside of aes.
- Add a line with the geom_abline geometry. geom_abline takes arguments slope (default = 1) and intercept (default = 0). Change the color with col or color and line type with lty.
- Placing the line layer after the point layer will overlay the line on top of the points. To overlay points on the line, place the line layer before the point layer.
- There are many additional ways to tweak your graph that can be found in the ggplot2 documentation, cheat sheet, or on the internet. For example, you can change the legend title with scale_color_discrete.

Code: Log-scale the x- and y-axis
# define p
library(tidyverse)
library(dslabs)
data(murders)
p <- murders %>% ggplot(aes(population/10^6, total, label = abb))

# log base 10 scale the x-axis and y-axis
p + geom_point(size = 3) +
    geom_text(nudge_x = 0.05) +
    scale_x_continuous(trans = "log10") +
    scale_y_continuous(trans = "log10")
    
# efficient log scaling of the axes
p + geom_point(size = 3) +
    geom_text(nudge_x = 0.075) +
    scale_x_log10() +
    scale_y_log10()
Code: Add labels and title
p + geom_point(size = 3) +
    geom_text(nudge_x = 0.075) +
    scale_x_log10() +
    scale_y_log10() +
    xlab("Population in millions (log scale)") +
    ylab("Total number of murders (log scale)") +
    ggtitle("US Gun Murders in 2010")
Code: Change color of the points

# redefine p to be everything except the points layer
p <- murders %>%
    ggplot(aes(population/10^6, total, label = abb)) +
    geom_text(nudge_x = 0.075) +
    scale_x_log10() +
    scale_y_log10() +
    xlab("Population in millions (log scale)") +
    ylab("Total number of murders (log scale)") +
    ggtitle("US Gun Murders in 2010")
    
# make all points blue
p + geom_point(size = 3, color = "blue")

# color points by region
p + geom_point(aes(col = region), size = 3)
Code: Add a line with average murder rate

# define average murder rate
r <- murders %>%
    summarize(rate = sum(total) / sum(population) * 10^6) %>%
    pull(rate)
    
# basic line with average murder rate for the country
p + geom_point(aes(col = region), size = 3) +
    geom_abline(intercept = log10(r))    # slope is default of 1
    
# change line to dashed and dark grey, line under points
p + 
    geom_abline(intercept = log10(r), lty = 2, color = "darkgrey") +
    geom_point(aes(col = region), size = 3)
    
Code: Change legend title
p <- p + scale_color_discrete(name = "Region")    # capitalize legend title


######### add-on packages - to complete the grpah ##########
Key points
The style of a ggplot graph can be changed using the theme function.
The ggthemes package adds additional themes.
The ggrepel package includes a geometry that repels text labels, ensuring they do not overlap with each other: geom_text_repel.

Code: Adding themes
# theme used for graphs in the textbook and course
library(dslabs)
ds_theme_set()

# themes from ggthemes
library(ggthemes)
p + theme_economist()    # style of the Economist magazine
p + theme_fivethirtyeight()    # style of the FiveThirtyEight website
Code: Putting it all together to assemble the plot

# load libraries
library(tidyverse)
library(ggrepel)
library(ggthemes)
library(dslabs)
data(murders)

# define the intercept
r <- murders %>%
    summarize(rate = sum(total) / sum(population) * 10^6) %>%
    .$rate
    
# make the plot, combining all elements
murders %>%
    ggplot(aes(population/10^6, total, label = abb)) +
    geom_abline(intercept = log10(r), lty = 2, color = "darkgrey") +
    geom_point(aes(col = region), size = 3) +
    geom_text_repel() +
    scale_x_log10() +
    scale_y_log10() +
    xlab("Population in millions (log scale)") +
    ylab("Total number of murders (log scale)") +
    ggtitle("US Gun Murders in 2010") +
    scale_color_discrete(name = "Region") +
    theme_economist()



########## other example ##########
Key points
geom_histogram creates a histogram. Use the binwidth argument to change the width of bins, the fill argument to change the bar fill color, and the col argument to change bar outline color.
geom_density creates smooth density plots. Change the fill color of the plot with the fill argument.
geom_qq creates a quantile-quantile plot. This geometry requires the sample argument. By default, the data are compared to a standard normal distribution with a mean of 0 and standard deviation of 1. This can be changed with the dparams argument, or the sample data can be scaled.
Plots can be arranged adjacent to each other using the grid.arrange function from the gridExtra package. First, create the plots and save them to objects (p1, p2, ...). Then pass the plot objects to grid.arrange.

Code: Histograms in ggplot2
# load heights data
library(tidyverse)
library(dslabs)
data(heights)

# define p
p <- heights %>%
    filter(sex == "Male") %>%
    ggplot(aes(x = height))
    
# basic histograms
p + geom_histogram()
p + geom_histogram(binwidth = 1)

# histogram with blue fill, black outline, labels and title
p + geom_histogram(binwidth = 1, fill = "blue", col = "black") +
    xlab("Male heights in inches") +
    ggtitle("Histogram")
    
Code: Smooth density plots in ggplot2
p + geom_density()
p + geom_density(fill = "blue")
Code: Quantile-quantile plots in ggplot2
# basic QQ-plot
p <- heights %>% filter(sex == "Male") %>%
    ggplot(aes(sample = height))
p + geom_qq()

# QQ-plot against a normal distribution with same mean/sd as data
params <- heights %>%
    filter(sex == "Male") %>%
    summarize(mean = mean(height), sd = sd(height))
p + geom_qq(dparams = params) +
    geom_abline()
    
# QQ-plot of scaled data against the standard normal distribution
heights %>%
    ggplot(aes(sample = scale(height)) +
    geom_qq() +
    geom_abline()
    
Code: Grids of plots with the grid.extra package
# define plots p1, p2, p3
p <- heights %>% filter(sex == "Male") %>% ggplot(aes(x = height))
p1 <- p + geom_histogram(binwidth = 1, fill = "blue", col = "black")
p2 <- p + geom_histogram(binwidth = 2, fill = "blue", col = "black")
p3 <- p + geom_histogram(binwidth = 3, fill = "blue", col = "black")

# arrange plots next to each other in 1 row, 3 columns
library(gridExtra)
grid.arrange(p1, p2, p3, ncol = 3)
