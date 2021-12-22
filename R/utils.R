#' Extract response table from sntask.
#'
#' @param x An sntask
#' @export
response_table <- function(x) UseMethod("response_table")
#' @export
response_table.sntask <- function(x) x$response_table


#' Extract description from sntask.
#'
#' @param x An sntask
#' @export
description <- function(x) UseMethod("description")
#' @export
description.sntask <- function(x) x$description

#' Get a value from task response table
#'
#' @param x An sntask
#' @param what the key name
#' @export
get <- function(x, what) UseMethod("get")
#' @export
get.sntask <- function(x, what) {
  rt <- response_table(x)
  rt[rt$key == what, "value" ,drop = TRUE]
}

