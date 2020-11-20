#' From a gene name, get the SNP ID, variation and topology
#' @export
get_gene_name_snp_variation_topology <- function(gene_name) { # nolint indeed a long and descriptive function name
  stop("ABANDON, split up")
  t <- tibble::tibble(
    snp_id = ncbi::get_snp_ids_from_gene_name(gene_name),
    variation = NA,
    is_in_tmh = NA
  )
  for (i in seq_len(nrow(t))) {
    snp_id <- t$snp_id[i]
    variation <- get_snp_variations_in_protein_from_snp_id(snp_id)
    if (length(variation) == 0) next
    protein_change <- NA
    tryCatch({
        protein_change <- ncbi::parse_hgvs(variation)
      }, error = function(e) {} # nolint ignore
    )
    if (length(protein_change) == 1 && is.na(protein_change)) next
    if (protein_change$from == protein_change$to) next
    t$variation[i] <- variation
  }

  for (i in seq_len(nrow(t))) {
    snp_id <- t$snp_id[i]
  }
  expect_true("snp_id" %in% names(t))
  expect_true("variation" %in% names(t))
  expect_true("is_in_tmh" %in% names(t))

}
