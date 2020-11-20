#' Get all variations for a SNP
#' @export
get_snp_variations <- function(snp_id) {
  ncbi::check_snp_id(snp_id)
  url <- paste0(
    "https://api.ncbi.nlm.nih.gov/variation/v0/beta/refsnp/",
    snp_id
  )
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
