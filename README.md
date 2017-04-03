
[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/duckduckr)](https://cran.r-project.org/package=duckduckr) [![Build Status](https://travis-ci.org/dirkschumacher/duckduckr.svg?branch=master)](https://travis-ci.org/dirkschumacher/duckduckr)

DuckduckR
=========

This is an *R* client for [https://duckduckgo.com/api](DuckDuckGo's%20Instant%20Answer%20API).

Install
-------

``` r
devtools::install_github("dirkschumacher/duckduckr")
```

Use
---

``` r
library(duckduckr)
res <- duckduck_answer("ggplot")
```

``` r
res$result$Abstract
```

<blockquote>
ggplot2 is a data visualization package for the statistical programming language R. Created by Hadley Wickham in 2005, ggplot2 is an implementation of Leland Wilkinson's Grammar of Graphics—a general scheme for data visualization which breaks up graphs into semantic components such as scales and layers. ggplot2 can serve as a replacement for the base graphics in R and contains a number of defaults for web and print display of common scales. Since 2005, ggplot2 has grown in use to become one of the most popular R packages. It is licensed under GNU GPL v2.
</blockquote>
