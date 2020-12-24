#' Get all variations for a SNP
#' @inheritParams default_params_doc
#' @return a character vector with variations.
#' Returns \code{character(0)} for a 'dead SNP' (e.g.
#' SNP ID \code{1466623805}, see
#' \url{https://api.ncbi.nlm.nih.gov/variation/v0/beta/refsnp/1466623805})
#' @export
get_snp_variations <- function(
  snp_id,
  verbose = FALSE
) {
  ncbi::check_snp_id(snp_id)
  url <- paste0(
    "https://api.ncbi.nlm.nih.gov/variation/v0/beta/refsnp/",
    format(x = snp_id, scientific = FALSE)
  )
  if (verbose) {
    message("url: '", url, "'")
  }

  # No scientific notation, such as SNP ID 1596000000
  # being converted to 1.596e+09 in URL
  testthat::expect_false(stringr::str_detect(string = url, pattern = "\\+"))

  json <- character(0)
  while (length(json) == 0) {
    try({
        json <- jsonlite::fromJSON(url)
      }
    )
  }
  alleles <- json$primary_snapshot_data$placements_with_allele$alleles
  if (is.null(alleles)) return(character(0))
  testthat::expect_equal(class(alleles), "list")
  n_alleles <- length(alleles)
  hgvses <- list()
  for (i in seq_len(n_alleles)) {
    # The first HGVS is not a variation
    hgvses[[i]] <- alleles[[i]]$hgvs[2]
  }
  unlist(hgvses)
}
