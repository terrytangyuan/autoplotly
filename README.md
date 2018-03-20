[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/autoplotly)](https://cran.r-project.org/package=autoplotly)
[![Travis-CI Build Status](https://travis-ci.org/rstudio/tfestimators.svg?branch=master)](https://travis-ci.org/rstudio/tfestimators) 

# autoplotly

This R package provides functionalities to automatically generate interactive visualizations for many
popular statistical results supported by [ggfortify](https://github.com/sinhrks/ggfortify)
package with [plotly.js](https://plot.ly) and [ggplot2](http://ggplot2.tidyverse.org/) style.
The generated visualizations can also be easily extended using ggplot2 syntax while staying interactive. Please check out some introductory examples [here](https://terrytangyuan.github.io/2018/02/12/autoplotly-intro/).

## Installation

To install the current version from CRAN, use:

``` r
install.packages("autoplotly")
```

To install from development version on Github, use:

``` r
devtools::install_github("terrytangyuan/autoplotly")
```

## Example

``` r
# Automatically generate interactive plot for results produced by `stats::prcomp`
p <- autoplotly(prcomp(iris[c(1, 2, 3, 4)]), data = iris,
  colour = 'Species', label = TRUE, label.size = 3, frame = TRUE)

# You can apply additional ggplot2 elements to the generated interactive plot
p +
  ggplot2::ggtitle("Principal Components Analysis") +
  ggplot2::labs(y = "Second Principal Components", x = "First Principal Components")

# Or apply additional plotly elements to the generated interactive plot
p %>% plotly::layout(annotations = list(
  text = "Example Text",
  font = list(
    family = "Courier New, monospace",
    size = 18,
    color = "black"),
  x = 0,
  y = 0,
  showarrow = TRUE))
```

You can `autoplotly` many other statistical results automatically with the help of [ggfortify](https://github.com/sinhrks/ggfortify). A complete list can be found [here](https://github.com/sinhrks/ggfortify#coverage).
