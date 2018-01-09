#' @export
autoplotly.default <- function(
  object,
  ...,
  width = NULL,
  height = NULL,
  tooltip = "all",
  dynamicTicks = FALSE,
  layerData = 1,
  originalData = TRUE,
  source = "A",
  margin = 0.02,
  shareX = TRUE,
  shareY = TRUE,
  titleX = shareX,
  titleY = shareY,
  which_layout = "merge") {

  autoplot_methods <- gsub("autoplot.", "", grep("autoplot.", ls(getNamespace("ggfortify")), value = TRUE))
  if (!any(class(object) %in% autoplot_methods)) {
    stop(paste0(
      "Only object of the following classes are supported for autoplotly: ",
      paste0(autoplot_methods, collapse = ", ")))
  }
  ggplot_obj <- autoplot(object, ...)
  if (is(ggplot_obj, "ggmultiplot")) {
    nplots <- length(ggplot_obj@plots)
    layout <- get.layout(nplots, ggplot_obj@ncol, ggplot_obj@nrow)
    plotly_obj <- subplot(
      lapply(ggplot_obj@plots, function(p) p + ggplot2::ggtitle("")),
      shareX = shareX,
      shareY = shareX,
      titleX = titleX,
      titleY = titleY,
      margin = margin,
      # ncols = ncol(layout), # TODO: plots[[i]][["frames"]] : subscript out of bounds. Potentially plotly issue
      # nrows = nrow(layout),
      which_layout = which_layout)
  } else {
    plotly_obj <- ggplotly(
      ggplot_obj,
      width = width,
      height = height,
      tooltip = tooltip,
      dynamicTicks = dynamicTicks,
      layerData = layerData,
      originalData = originalData, source = source)
  }
  plotly_obj$ggplot_obj <- ggplot_obj
  plotly_obj
}

get.layout <- function(nplots, ncol, nrow) {
  if (ncol == 0 && nrow == 0) {
    ncol <- 2
  } else if (ncol == 0 && nrow != 0) {
    ncol <- ceiling(nplots / nrow)
  }
  if (nrow == 0) {
    nrow <- ceiling(nplots / ncol)
  } else {
    nrow <- nrow
  }
  if (nrow * ncol < nplots) {
    message <- paste('nrow * ncol (', nrow, '*', ncol,
                     ')must be larger than number of plots', nplots)
    stop(message)
  }
  t(matrix(1:(ncol * nrow), ncol = nrow, nrow = ncol))
}
