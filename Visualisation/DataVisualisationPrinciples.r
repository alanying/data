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
