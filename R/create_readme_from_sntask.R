#' Create a README from a task
#'
#' @param task an object of sntask
#' @param path Path or connection to write to
#'
#' @return invisible task
#' @export
create_readme_from_sntask <- function(task, path) {
  stopifnot("'task' is not an object of 'sntask.'" = is.sntask(task))
  df <- response_table(task)
  lines <- paste(
    lapply(split(df, 1:nrow(df)), function(x) paste(unlist(x), collapse = ": ")),
    collapse = "\n"
  )
  readr::write_file(lines, path)
  readr::write_lines("\n-------------------\n", path, append = TRUE)
  readr::write_lines(description(task), path, append = TRUE)
  invisible(task)
}
