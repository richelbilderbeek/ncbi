#' Extract the protein IDs from variations
#' @inheritParams default_params_doc
#' @export
extract_protein_ids_from_variations <- function(variations) { # nolint indeed a long function name
  stringr::str_match(
    variations, "^(.*):p\\..*$"
  )[, 2]
}
