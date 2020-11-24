#' Create a multiple sequence alignment using COBALT
#' @inheritParams cobaltr::run_cobalt
#' @return the FASTA text of the MSA
create_msa <- function(
  fasta_text,
  cobalt_options = cobaltr::create_cobalt_options(),
  cobalt_folder = cobaltr::get_default_cobalt_folder()
) {
  fasta_filename <- tempfile()
  writeLines(text = fasta_text, con = fasta_filename)

  cobaltr::run_cobalt(
    fasta_filename = fasta_filename,
    cobalt_options = cobalt_options,
    cobalt_folder = cobalt_folder
  )

}
