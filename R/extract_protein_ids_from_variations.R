#' Extract the protein IDs from variations
#' @export
extract_protein_ids_from_variations <- function(variations) {
  stringr::str_match(
    variations, "^(.*):p\\..*$"
  )[, 2]
}
