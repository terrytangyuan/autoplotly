context("Testing all functionalities")

df <- iris[c(1, 2, 3, 4)]
result <- prcomp(df)

test_that("autoplotly works correctly", {
  p <- autoplotly(result, data = iris, colour = 'Species', label = TRUE, label.size = 3, frame = TRUE)
  expect_true(inherits(p, "plotly"))
  expect_true(inherits(p$ggplot_obj, c("ggplot", "ggplot2::ggplot")))
})

test_that("autoplotly is composable with additional ggplot2 elements", {
  p <- autoplotly(result, data = iris, colour = 'Species', label = TRUE, label.size = 3, frame = TRUE)
  p <- p + ggplot2::ggtitle("This is a custom title") + ggplot2::labs(y = "Second Principal Components", x = "First Principal Components")
  expect_true(inherits(p, "plotly"))
  expect_true(inherits(p$ggplot_obj, c("ggplot", "ggplot2::ggplot")))
})

test_that("Errors are thrown when class is not supported by ggfortify", {
  a <- 1
  class(a) <- "None"
  expect_error(autoplotly(a, data = iris, colour = 'Species', label = TRUE, label.size = 3, frame = TRUE), "Only object of the following classes are supported for autoplotly")
})

test_that("autoplotly accepts additional plotly args", {
  p <- autoplotly(result, data = iris, colour = 'Species', label = TRUE, label.size = 3, frame = TRUE,
                  tooltip = "all", dynamicTicks = FALSE, layerData = 1, originalData = TRUE, source = "A")
  expect_true(inherits(p, "plotly"))
  expect_true(inherits(p$ggplot_obj, c("ggplot", "ggplot2::ggplot")))
})

test_that("tooltip accepts columns from the fortified data", {
  p <- autoplotly(
    result,
    data = iris,
    colour = "Species",
    frame = TRUE,
    tooltip = c("x", "y", "colour", "Sepal.Length", "Petal.Length")
  )
  built <- plotly::plotly_build(p)
  tooltip_text <- unlist(lapply(built$x$data, function(trace) trace$text))
  frame_traces <- Filter(function(trace) {
    identical(trace$fill, "toself")
  }, built$x$data)

  expect_true(any(grepl("Sepal.Length: 5.1", tooltip_text, fixed = TRUE)))
  expect_true(any(grepl("Petal.Length: 1.4", tooltip_text, fixed = TRUE)))
  expect_length(frame_traces, length(levels(iris$Species)))
  expect_true(all(vapply(frame_traces, function(trace) {
    length(trace$x) > 2L
  }, logical(1))))
})

test_that("existing tooltip aesthetics are unchanged", {
  p <- autoplotly(
    result,
    data = iris,
    colour = "Species",
    tooltip = c("x", "y", "colour")
  )

  expect_false(".autoplotly_tooltip" %in% names(p$ggplot_obj$data))
})

test_that("tooltip columns work with layers that inherit plot data", {
  basis <- splines::ns(seq_len(100), df = 4)
  p <- autoplotly(
    basis,
    tooltip = c("x", "y", "Spline")
  )
  built <- plotly::plotly_build(p)
  tooltip_text <- unlist(lapply(built$x$data, function(trace) trace$text))

  expect_true(any(grepl("Spline: 1", tooltip_text, fixed = TRUE)))
})
