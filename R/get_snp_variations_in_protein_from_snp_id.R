#' From a SNP id, get the variations at the protein level.
#' Returns \code{character(0)} if there are none
#' @export
get_snp_variations_in_protein_from_snp_id <- function(snp_id) { # nolint indeed a long and descriptive function name
  variations <- ncbi::get_snp_variations(snp_id = snp_id)
  stringr::str_subset(
    variations,
    ":p\\."
  )
}
