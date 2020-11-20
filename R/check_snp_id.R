#' Check a SNP ID
#' @export
check_snp_id <- function(snp_id) {
  if (length(snp_id) != 1 || is.na(snp_id)) {
    stop("'snp_id' must be one SNP ID. Current value: ", snp_id)
  }
  if (is.character(snp_id)) {
    if (nchar(snp_id) == 0) {
      stop("'snp_id' must have at least 1 character")
    }
  } else if (is.infinite(snp_id)) {
    stop("'snp_id' must be a finite integer")
  } else if (abs(snp_id - round(snp_id)) > 0.00001) {
    stop("'snp_id' must be a finite integer")
  }
}
