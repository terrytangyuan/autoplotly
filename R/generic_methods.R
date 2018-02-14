#' @export
"+.plotly" <- function(p, ggplot_element) {
  ggplot_obj <- tryCatch(
    p$ggplot_obj + ggplot_element,
    # Slightly better error message
    error = function(e) {
      if (grepl("Don't know how to add", e$message)) {
        stop("You are using ggplot2 with incorrect syntax.",
             "Please visit http://ggplot2.tidyverse.org/index.html for tutorials.")
      }
    }
  )
  autoplotly(ggplot_obj)
}

#' Automatic Visualization of Popular Statistical Results Using 'plotly.js' and 'ggplot2'
#'
#' @description This function provides functionality to automatically generate interactive
#' plot for many popular statistical results supported by 'ggfortify' package using 'plotly.js' and 'ggplot2'.
#'
#' @param object The object that represents your statistical result, e.g. `stats::prcomp(iris[-5])`.
#' @param ... Arguments passed to `ggfortify::autoplot` function for the applied
#'   object. For example, if your object is constructed from `stats::prcomp(iris[-5])`,
#'   you can find the documentation for the list of additional arguments via
#'   `?ggfortify:::autoplot.prcomp()`.
#' @inheritParams plotly::ggplotly
#' @inheritParams plotly::subplot
#' @export
#' 
#' @examples
#' # Automatically generate interactive plot for results produced by `stats::prcomp`
#' p <- autoplotly(prcomp(iris[c(1, 2, 3, 4)]), data = iris,
#'                 colour = 'Species', label = TRUE, label.size = 3, frame = TRUE)
#' 
#' # You can apply additional ggplot2 elements to interactive plot built using `autoplotly()`
#' p +
#'   ggplot2::ggtitle("Principal Components Analysis") +
#'   ggplot2::labs(y = "Second Principal Components", x = "First Principal Components")
#' 
#' # Or apply additional plotly elements to the generated interactive plot
#' p %>% plotly::layout(annotations = list(
#'   text = "Example Text",
#'   font = list(
#'     family = "Courier New, monospace",
#'     size = 18,
#'     color = "black"),
#'   x = 0,
#'   y = 0,
#'   showarrow = TRUE))
autoplotly <- function(object,
                       ...,
                       width = NULL,
                       height = NULL,
                       tooltip = "all",
                       dynamicTicks = FALSE,
                       layerData = 1,
                       originalData = TRUE,
                       source = "A",
                       widths = NULL,
                       heights = NULL,
                       margin = 0.02,
                       shareX = TRUE,
                       shareY = TRUE,
                       titleX = shareX,
                       titleY = shareY,
                       which_layout = "merge") {
  UseMethod("autoplotly")
}
