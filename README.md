
[![CRAN\_Status\_Badge](http://www.r-pkg.org/badges/version/duckduckr)](https://cran.r-project.org/package=duckduckr) [![Build Status](https://travis-ci.org/dirkschumacher/duckduckr.svg?branch=master)](https://travis-ci.org/dirkschumacher/duckduckr) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/dirkschumacher/duckduckr?branch=master&svg=true)](https://ci.appveyor.com/project/dirkschumacher/duckduckr) [![Coverage Status](https://img.shields.io/codecov/c/github/dirkschumacher/duckduckr/master.svg)](https://codecov.io/github/dirkschumacher/duckduckr?branch=master)

DuckduckR
=========

This is a simple *R* client for [DuckDuckGo's Instant Answer API](https://duckduckgo.com/api).

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

# meta data of the call is part of the attributes
stopifnot(attr(res, "status") == "OK")

# the original http call
attr(res, "source")
#> [1] "https://api.duckduckgo.com/?q=ggplot&no_redirect=0&no_html=0&format=json&skip_disambig=0&t=duckduckr"
```

``` r
res$Abstract
```

<blockquote>
ggplot2 is a data visualization package for the statistical programming language R. Created by Hadley Wickham in 2005, ggplot2 is an implementation of Leland Wilkinson's Grammar of Graphics—a general scheme for data visualization which breaks up graphs into semantic components such as scales and layers. ggplot2 can serve as a replacement for the base graphics in R and contains a number of defaults for web and print display of common scales. Since 2005, ggplot2 has grown in use to become one of the most popular R packages. It is licensed under GNU GPL v2.
</blockquote>
 

Contributing
------------

If you found a bug or want to propose a feature, feel free to visit the [issues page](https://github.com/dirkschumacher/duckduckr/issues).
