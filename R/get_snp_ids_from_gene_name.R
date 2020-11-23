#' Get all the SNP IDs for a certain gene
#' @inheritParams default_params_doc
#' @return a character vector
#' @export
get_snp_ids_from_gene_name <- function(gene_name) {
  search_result <- rentrez::entrez_search(
    db = "SNP",
    term = paste0("", gene_name, "[Gene Name]"),
    retmax = 1000001 # Prevent the change to scientific notation
  )
  Sys.sleep(1)
  # Check that we indeed have all results
  testthat::expect_equal(search_result$count, search_result$retmax)
  search_result$ids
}
