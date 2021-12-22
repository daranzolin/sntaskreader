#' Read a Task PDF from ServiceNow
#'
#' @param file Path to PDF
#' @importFrom readr read_fwf fwf_widths
#' @importFrom stats na.omit setNames
#'
#' @return a sntask() object
#' @export
read_sntask <- function(file) {

  cn <- c("key", "value")
  x <- pdftools::pdf_text(file)
  lines <- unlist(strsplit(x, "\\n"))
  resp_tbl_lines <- lines[grep_range(lines, "^Number", "^Configuration item:")]

  cw <- max(ceiling(nchar(resp_tbl_lines)/4))
  task_kv <- setNames(
    suppressWarnings(read_fwf(resp_tbl_lines, fwf_widths(rep(cw, 4)))),
    NA
    )
  resp_tbl <- na.omit(setNames(rbind(task_kv[,1:2], task_kv[,3:4]), cn))
  resp_tbl[["key"]] <- gsub(":$", "", resp_tbl[["key"]])

  desc <- paste(lines[grep_range(lines, "Purpose = ", "^Watch list:", 6)], collapse = " ")
  desc <- gsub("^Purpose = ", "", desc)

  more <- grep("^One-on|^Recurring|^Date Needed|^Additional Comments", lines, value = TRUE)
  more <- lapply(strsplit(more, " ="), function(x) {
    setNames(as.data.frame(matrix(x, ncol = 2)), cn)
    }
  )
  more <- do.call(rbind, more)

  resp_tbl_out <- rbind(resp_tbl, more)
  resp_tbl_out[["key"]] <- gsub(":$", "", resp_tbl_out[["key"]])
  resp_tbl_out[["value"]] <- trimws(resp_tbl_out[["value"]])

  out <- sntask(
    response_table = resp_tbl_out,
    description = desc
  )
  return(out)
}

grep_range <- function(x, start_grep, end_grep, decrement = 0) {
  s <- min(grep(start_grep, x))
  e <- grep(end_grep, x) - decrement
  seq(s, e, by = 1)
}

