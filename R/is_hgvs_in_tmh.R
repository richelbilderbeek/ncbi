#' Determine if a HGVS is a mutation in a TMH part of membrane protein
#' @export
is_hgvs_in_tmh <- function(hgvs) {

  if (length(hgvs) == 0) {
    stop("Variation does not have an effect at the protein level")
  }
  variation <- parse_hgvs(hgvs)

  if (variation$from == variation$to) {
    stop("Variation '", hgvs, "' does not change an amino acid")
  }

  # Get the protein ID
  protein_info <- rentrez::entrez_search(
    db = "protein",
    term = variation$name,
    rettype = "xml"
  )
  Sys.sleep(1)
  protein_id <- protein_info$ids
  # Get the protein sequence as a FASTA text
  protein_fasta <- rentrez::entrez_fetch(
    db = "protein",
    id = protein_id,
    rettype = "fasta"
  )
  Sys.sleep(1)
  testthat::expect_equal(1, length(protein_fasta))

  protein_text <- stringr::str_split(protein_fasta, "\n")[[1]]

  testthat::expect_true(length(protein_text) >= 2)
  topology = pureseqtmr::predict_topology_from_sequence(
    protein_sequence = paste0(protein_text[-1], collapse = "")
  )
  if (is.na(stringr::str_match(topology, "1"))) {
    stop("This protein is not predicted to be a membrane protein")
  }
  snp_topology <- stringr::str_sub(topology, variation$pos, variation$pos)
  testthat::expect_true(snp_topology == "0" || snp_topology == "1")
  snp_topology == "1"
}
