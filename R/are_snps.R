#' Determine if the one or more strings are a SNP in HGVS sequence.
#' This is the vectorized version of \link{is_snp}
#' @inheritParams default_params_doc
#' @examples
#' # These are SNPs
#' are_snps("NP_001771.1:p.Ser91Pro")
#' are_snps("NP_001254627.1:p.Val237Met")
#' are_snps("NP_055635.3:p.Ala55Gly")
#'
#' # A synonymous mutation at the DNA level is no SNP
#' are_snps(s = "NP_001771.1:p.Phe89=")
#'
#' # A deletion is no SNP
#' are_snps("NP_001771.1:p.Leu64_Gly74del")
#'
#' # A frame shift at the DNA level is no SNP
#' are_snps("NP_001771.1:p.Asp167fs")
#' @export
are_snps <- function(s) {
  results <- rep(NA, length(s))
  for (i in seq_along(s)) {
    results[i] <- is_snp(s[i])
  }
  results
}
