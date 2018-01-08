# autoplotly - Automatic Generation of Interactive Plots for Popular Statistical Results

This R package provides functionalities to automatically generate interactive plot for many
popular statistical results supported by [ggfortify](https://github.com/sinhrks/ggfortify)
package with [plotly.js](https://plot.ly) and [ggplot2](http://ggplot2.tidyverse.org/) style.
The generated plot can also be easily extended using ggplot2 syntax while keeping the plot interactive.

## Installation

``` r
devtools::install_github("terrytangyuan/autoplotly")
```

## Example

``` r
# Automatically generate interactive plot for results produced by `stats::prcomp`
p <- autoplotly(prcomp(iris[c(1, 2, 3, 4)]), data = iris, colour = 'Species', label = TRUE, label.size = 3, frame = TRUE)

# You can apply additional ggplot2 elements to interactive plot built using `autoplotly()`
p <- p + ggplot2::ggtitle("Principal Components Analysis") + ggplot2::labs(y = "Second Principal Components", x = "First Principal Components")
p
```

You can `autoplotly` many other statistical results automatically with the help of [ggfortify](https://github.com/sinhrks/ggfortify). A complete list can be found [here](https://github.com/sinhrks/ggfortify#coverage).
