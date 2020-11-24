create_msa <- function(fasta_text) {
  # Get the AA sequences from the IDs of similar sequences
  fasta_filename <- tempfile()
  writeLines(text = fasta_text, con = fasta_filename)


  ape::clustalomega(
    ape::read.FASTA(fasta_filename, type = "AA"),
    file = fasta_filename
  )

  if (1 == 2) {
    # Cannot convert output to a FASTA file, due to three separate bugs

    sequences <- Biostrings::readAAStringSet(fasta_filename)
    library(msa)
    msa <- msa::msa(
      inputSeqs = sequences,
      method = "ClustalOmega"
    )
  }
  if (1 == 2) {
    # msa::msaConvert to AAbin format results in incorrect FASTA file
    # https://github.com/UBod/msa/issues/7
    msa_as_ape_aabin <- msa::msaConvert(msa, "ape::AAbin")
    ape::write.FASTA(x = msa_as_ape_aabin, file = fasta_filename)
  }
  if (1 == 2) {
    # msa::msaConvert to seqinr format results in incorrect FASTA file
    # https://github.com/UBod/msa/issues/6
    msa_as_seqinr_alignment <- msa::msaConvert(msa, "seqinr::alignment")
    seqinr::write.fasta(
      sequences = msa_as_seqinr_alignment$seq,
      names = names(sequences),
      file.out = fasta_filename
    )
  }
  readLines(fasta_filename)
  readr::read_lines(file = fasta_filename)
}
