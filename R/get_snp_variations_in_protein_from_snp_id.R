#' From a SNP id, get the variations at the protein level.
#' Returns \code{character(0)} if there are none
#' @inheritParams default_params_doc
#' @export
get_snp_variations_in_protein_from_snp_id <- function(snp_id) { # nolint indeed a long and descriptive function name
  ncbi::check_snp_id(snp_id)
  variations <- ncbi::get_snp_variations(snp_id = snp_id)
  if (length(variations) == 0) return(character(0))
  stringr::str_subset(
    variations,
    ":p\\."
  )
}
