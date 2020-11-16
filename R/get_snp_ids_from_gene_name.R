#' Get all the SNP IDs for a certain gene
#' @export
get_snp_ids_from_gene_name <- function(gene_name) {
  search_result <- rentrez::entrez_search(
    db = "SNP",
    term = paste0("", gene_name, "[Gene Name]"),
    retmax = 50000
  )
  Sys.sleep(1)
  # Check that we indeed have all results
  testthat::expect_equal(search_result$count, search_result$retmax)
  search_result$ids
}
