#' Standard error of the mean
#'
#' @param x A numeric vector
#' @param na.rm a logical value indicating whether NA values should 
#' be stripped before the computation proceeds.
#'
#' @return Returns the standard error of the mean of the values in x is computed.
#' @export
#'
#' @examples
#' se(x = rnorm(n = 1000, mean = 10, sd = 10))
se <- function(x, na.rm=FALSE) {
  if (na.rm) x <- na.omit(x)
  sqrt(var(x)/length(x))
}

save_data <- function(x, path, name) {
  # Check arguments
  stopifnot(is.data.frame(x))
  stopifnot(is.character(path))
  stopifnot(is.character(name))
  
  fn_csv <- paste(path, objn, ".csv", sep = "")
  fn_rds <- paste(path, objn, ".RDs", sep = "")
  readr::write_csv(x = x, path = fn_csv)
  saveRDS(object = x, file = fn_rds)
  
  # Check if can read back
  suppressMessages({
    d1 <- readr::read_csv(file = fn_csv)
    d2 <- readRDS(file = fn_rds)
  })
  if (all.equal(d1, x) & 
      all.equal(d2, x) & 
      all.equal(d1, d2)) {
    cat("The files below were saved and reloaded correctly: ", "\n")
    cat("1.", fn_csv, "\n")
    cat("2.", fn_rds, "\n")
  }
} 