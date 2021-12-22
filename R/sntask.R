sntask <- function(...) {
  structure(list(...), class = "sntask")
}

is.sntask <- function(x) {
  inherits(x, "sntask")
}

#' @export
print.sntask <- function(x, ...) {

  cat("Responses", "\n")
  cat(rep("-", 10), "\n")
  rt <- response_table(x)
  for (i in 1:nrow(rt)) {
    cat(paste0(rt[i,1], ": ", rt[i,2]), "\n")
  }
  cat("\n\n")
  cat("Description", "\n")
  cat(rep("-", 10), "\n")
  cat(description(x))
  invisible(x)
}
