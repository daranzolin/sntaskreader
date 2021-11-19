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
