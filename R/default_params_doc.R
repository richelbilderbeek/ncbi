#' This function does nothing. It is intended to inherit is parameters'
#' documentation.
#' @param chunk_size the number of protein IDs in an NCBI quey.
#'   Too many values results in an NCBI API error
#' @param fasta_file name of a FASTA file
#' @param fasta_text text in the same format as a FASTA file
#' @param gene_ids one or more IDs of a gene
#' @param gene_name name of a gene
#' @param hgvs a variation in HGVS ('Human Genome Variation Society') format
#' @param protein_id ID of a protein.
#'   For example, \code{NP_001007554.1} is a protein ID.
#' @param protein_ids one or more protein IDs.
#'   For example, \code{NP_001007554.1} is a protein ID.
#' @param snp_id the ID of a SNP
#' @param subject_ids one of more IDs of a subject
#' @param variation one variation.
#'   For example, \code{NP_009089.4:p.Val723Gly} is a variation.
#' @param variations one or more variations.
#'   For example, \code{NP_009089.4:p.Val723Gly} is a variation.
#' @param verbose set to TRUE for more output
#' @author Richèl J.C. Bilderbeek
#' @note This is an internal function, so it should be marked with
#'   \code{@noRd}. This is not done, as this will disallow all
#'   functions to find the documentation parameters
default_params_doc <- function(
  chunk_size,
  fasta_file,
  fasta_text,
  gene_ids,
  gene_name,
  hgvs,
  protein_id,
  protein_ids,
  snp_id,
  subject_ids,
  variation,
  variations,
  verbose
) {
  # Nothing
}
