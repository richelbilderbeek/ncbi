#' Check a SNP ID
#' @export
check_snp_id <- function(snp_id) {
  if (length(snp_id) != 1 || is.na(snp_id) || !is.character(snp_id) ||
      nchar(snp_id) == 0) {
    stop("'snp_id' must be one SNP ID. Current value: ", snp_id)
  }
}
