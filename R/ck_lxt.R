#' Check data for a line by tester genetic design
#'
#' This function checks the data structure for a line by tester genetic design.
#' @param dfr The name of the data frame.
#' @param line The name of the column that identifies the lines.
#' @param tester The name of the column that identifies the testers.
#' @return Three control values, the number of lines (\code{nlin}),
#' and the number of testers (\code{ntes}). The control values are:
#' \itemize{
#'  \item \code{c1}: TRUE if all lines appear as parents.
#'  \item \code{c2}: TRUE if all testers appear as parents.
#'  \item \code{c3}: TRUE if all lines x testers are in the crosses.
#' }
#' @author Raul Eyzaguirre.
#' @examples
#' ck.lxt(lxt, "line", "tester")
#' @export

ck.lxt <- function(dfr, line, tester) {
  
  # Get names and number of lines, testers, and crosses
  
  out <- ck.fs(dfr, c("line", "tester"))
  
  nlin <- out$nl[1]
  ntes <- out$nl[2]
  nlxt <- out$nt
  llin <- out$lf[[1]]
  ltes <- out$lf[[2]]

  # Check that all lines appear as parents
  
  tmp <- dfr[is.na(dfr[, tester]), ]
  c1 <- identical(llin, unique(tmp[!is.na(tmp[, line]), line]))
  
  # Check that all testers appear as parents
  
  tmp <- dfr[is.na(dfr[, line]), ]
  c2 <- identical(ltes, unique(tmp[!is.na(tmp[, tester]), tester]))
  
  # Check that there are nl x nt crosses
  
  c3 <- as.numeric(nlin * ntes) == nlxt
  
  # Return
  
  list(c1 = c1, c2 = c2, c3 = c3, nlin = nlin, ntes = ntes)
  
}
