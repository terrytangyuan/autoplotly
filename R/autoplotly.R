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
      shareY = shareY,
      titleX = titleX,
      titleY = titleY,
      margin = margin,
      # ncols = ncol(layout), # TODO: plots[[i]][["frames"]] : subscript out of bounds. Potentially plotly issue
      # nrows = nrow(layout),
      which_layout = which_layout)
  } else {
    tooltip_options <- add_tooltip_columns(ggplot_obj, tooltip)
    ggplot_obj <- tooltip_options$plot
    tooltip <- tooltip_options$tooltip
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

add_tooltip_columns <- function(ggplot_obj, tooltip) {
  if (!is.character(tooltip) ||
      length(tooltip) == 0L ||
      identical(tooltip, "all") ||
      !is.data.frame(ggplot_obj$data)) {
    return(list(plot = ggplot_obj, tooltip = tooltip))
  }

  mapped_aesthetics <- c(
    names(ggplot_obj$mapping),
    unlist(lapply(ggplot_obj$layers, function(layer) {
      names(layer$mapping)
    }), use.names = FALSE)
  )
  tooltip_columns <- unique(tooltip[
    tooltip %in% names(ggplot_obj$data) &
      !(tooltip %in% mapped_aesthetics)
  ])

  if (length(tooltip_columns) == 0L) {
    return(list(plot = ggplot_obj, tooltip = tooltip))
  }

  tooltip_name <- ".autoplotly_tooltip"
  ggplot_obj$data[[tooltip_name]] <- format_tooltip_columns(
    ggplot_obj$data,
    tooltip_columns
  )

  tooltip_layer <- NULL
  for (i in seq_along(ggplot_obj$layers)) {
    layer_data <- ggplot_obj$layers[[i]]$data
    if (is.data.frame(layer_data) &&
        nrow(layer_data) == nrow(ggplot_obj$data) &&
        all(tooltip_columns %in% names(layer_data))) {
      tooltip_layer <- i
      break
    }
  }

  if (is.null(tooltip_layer)) {
    reference_geoms <- c(
      "GeomPolygon", "GeomRibbon", "GeomRect",
      "GeomSegment", "GeomVline", "GeomHline"
    )
    for (i in seq_along(ggplot_obj$layers)) {
      layer <- ggplot_obj$layers[[i]]
      if ((is.null(layer$data) || inherits(layer$data, "waiver")) &&
          !inherits(layer$geom, reference_geoms)) {
        tooltip_layer <- i
        break
      }
    }
  }

  if (is.null(tooltip_layer)) {
    return(list(plot = ggplot_obj, tooltip = tooltip))
  }

  layer_data <- ggplot_obj$layers[[tooltip_layer]]$data
  if (is.data.frame(layer_data)) {
    layer_data[[tooltip_name]] <- format_tooltip_columns(
      layer_data,
      tooltip_columns
    )
    ggplot_obj$layers[[tooltip_layer]]$data <- layer_data
  }

  .autoplotly_tooltip <- NULL
  text_mapping <- ggplot2::aes(text = .autoplotly_tooltip)
  ggplot_obj$layers[[tooltip_layer]]$mapping$text <- text_mapping$text

  tooltip[tooltip %in% tooltip_columns] <- "text"
  list(plot = ggplot_obj, tooltip = unique(tooltip))
}

format_tooltip_columns <- function(data, columns) {
  if (nrow(data) == 0L || length(columns) == 0L) {
    return(rep("", nrow(data)))
  }

  vapply(seq_len(nrow(data)), function(row) {
    values <- vapply(columns, function(column) {
      value <- data[[column]][row]
      paste0(column, ": ", paste(as.character(value), collapse = ", "))
    }, character(1))
    paste(values, collapse = "<br>")
  }, character(1))
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
