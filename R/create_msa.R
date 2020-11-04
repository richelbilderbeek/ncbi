create_msa <- function(fasta_text) {
  # Get the AA sequences from the IDs of similar sequences
  fasta_filename <- tempfile()
  writeLines(text = fasta_text, con = fasta_filename)
  sequences <- Biostrings::readAAStringSet(fasta_filename)

  # Fails: 'object 'msaClustalOmega' of mode 'function' was not found'
  library(msa)

  msa <- msa::msa(
    inputSeqs = sequences,
    method = "ClustalOmega"
  )

  msa_as_ape_aabin <- msa::msaConvert(msa, "ape::AAbin")
  ape::write.FASTA(x = msa_as_ape_aabin, file = fasta_filename)

  if (1 == 2) {
    # FAILS
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
  if (1 == 3) {
    # bios2mds::export.fasta adds NAs for short sequences
    # Bugreport at https://github.com/richelbilderbeek/reports/issues/1
    msa_as_bios2mds_align <- msa::msaConvert(msa, "bios2mds::align")
    bios2mds::export.fasta(msa_as_bios2mds_align, outfile = fasta_filename)
  }
  readLines(fasta_filename)
  readr::read_lines(file = fasta_filename)
}
