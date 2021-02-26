#' Determine if the string is a SNP in HGVS sequence
#' @inheritParams default_params_doc
#' @examples
#' # These are SNPs
#' is_snp("NP_001771.1:p.Ser91Pro")
#' is_snp("NP_001254627.1:p.Val237Met")
#' is_snp("NP_055635.3:p.Ala55Gly")
#' # Also a mutation at the terminator is a SNP
#' is_snp("NP_005124.1:p.Ter330Cys")
#'
#' # A synonymous mutation at the DNA level is no SNP
#' is_snp(s = "NP_001771.1:p.Phe89=")
#'
#' # A deletion is no SNP
#' is_snp("NP_001771.1:p.Leu64_Gly74del")
#'
#' # A frame shift at the DNA level is no SNP
#' is_snp("NP_001771.1:p.Asp167fs")
#' @export
is_snp <- function(s) {
  is_valid <- FALSE
  tryCatch({
    hgvs <- ncbi::parse_hgvs(s)
    is_valid <- hgvs$from != hgvs$to
  }, error = function(e) {} # nolint no worries
  )
  is_valid
}
