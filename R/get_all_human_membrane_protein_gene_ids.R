#' Get all the human membrane protein gene names
#' @export
get_all_human_membrane_protein_gene_ids <- function() { # nolint keep long descriptive function name
  search_result <- rentrez::entrez_search(
    db = "Gene",
    term = "((membrane protein) AND Homo sapiens[ORGN]) AND alive[prop]",
    retmax = 2000
  )
  Sys.sleep(1)
  # Check that we indeed have all results
  testthat::expect_equal(search_result$count, search_result$retmax)
  search_result$ids
}
