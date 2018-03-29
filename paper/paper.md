---
title: '`autoplotly`: An R package for automatic generation of interactive visualizations
  for statistical results'
authors:
- affiliation: 1
  name: Yuan Tang
  orcid: 0000-0001-5243-233X
date: "29 March 2018"
output: pdf_document
bibliography: paper.bib
tags:
- R
- interactive data visualization
- statistics
- time series
- machine learning
affiliations:
- index: 1
  name: "H2O.ai"
---

# Summary

Often times users only want to quickly iterate the process of exploring data, building statistical models, and visualizing the model results, especially the models that focus on common tasks such as clustering and time series analysis. Some of these packages provide default visualizations using base R's `plot()` for the data and models they generate. However, they look out-of-fashion and these components require additional transformation and clean-up before using them in `ggplot2` [@wickham2009ggplot2] and each of those transformation steps must be replicated by others when they wish to produce similar charts in their analyses. Creating a central repository for common/popular transformations and default plotting idioms would reduce the amount of effort needed by all to create compelling, consistent and informative charts. The `ggfortify` [@rjggfortify; @ggfortify] package provides a unified `ggplot2` plotting interface to many statistics and machine learning packages and functions in order to help these users achieve reproducibility goals with minimal effort. `ggfortify` package has a very easy-to-use and uniform programming interface that enables users to use one line of code to visualize statistical results of many popular R packages using `ggplot2` as building blocks. This helps statisticians, data scientists, and researchers avoid both repetitive work and the need to identify the correct `ggplot2` syntax to achieve what they need. Users are able to generate beautiful visualizations of their statistical results produced by popular packages with minimal effort. `plotly` [@plotly] is an R package built on top of Javascript visualization framework `plotly.js` that become popular building blocks for creating interactive visualizations in R.

The `autoplotly` [@autoplotly] package is an extension built on top of R packages `ggplot2`, `plotly`, and `ggfortify` to provide functionalities to automatically generate interactive visualizations for many popular statistical results supported by `ggfortify` package, such as time series, PCA, clustering and survival analysis, with `plotly` and `ggplot2` style. The generated visualizations can also be easily extended using `ggplot2` and `plotly` syntax while staying interactive.

# References
