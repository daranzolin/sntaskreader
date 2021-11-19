#' Read a Task PDF from ServiceNow
#'
#' @param file Path to PDF
#'
#' @return a sntask() object
#' @export
read_sntask <- function(file) {

  cn <- c("key", "value")
  x <- pdftools::pdf_text(file)
  lines <- unlist(strsplit(x, "\\n"))
  resp_tbl_lines <- lines[15:20]

  task_kv <- setNames(
    suppressWarnings(
      readr::read_fwf(resp_tbl_lines, readr::fwf_widths(rep(40, 4)))
      ),
    NA
    )
  resp_tbl <- na.omit(setNames(rbind(task_kv[,1:2], task_kv[,3:4]), cn))
  resp_tbl[["key"]] <- gsub(":$", "", resp_tbl[["key"]])

  desc_start <- min(grep("Purpose =", lines))
  desc_end <- grep("Staff Member = ", lines)
  desc <- paste(lines[desc_start:(desc_end - 1)], collapse = " ")
  desc <- gsub("^Purpose = ", "", desc)

  more <- grep("^One-on|^Recurring|^Date Needed|^Additional Comments", lines, value = TRUE)
  more <- lapply(strsplit(more, " ="), function(x) {
    setNames(as.data.frame(matrix(x, ncol = 2)), c("key", "value"))
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

