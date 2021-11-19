
# sntaskreader

<!-- badges: start -->
<!-- badges: end -->

The goal of sntaskreader is to read the PDF task exports from ServiceNow into R.

## Installation

You can install the released version of sntaskreader from GitHub with:

``` r
remotes::install_github("ir-sfsu/sntaskreader")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(sntaskreader)
task <- read_sntask("path_to_task_pdf")
```

