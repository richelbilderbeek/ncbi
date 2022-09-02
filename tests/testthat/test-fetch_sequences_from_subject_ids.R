test_that("use", {
  Sys.sleep(2)
  sequence <- fetch_sequences_from_subject_ids(subject_ids = "4ZW9_A")
  fasta_filename <- tempfile()
  readr::write_lines(sequence, fasta_filename)
  expect_silent(seqinr::read.fasta(file = fasta_filename, seqtype = "AA"))
})
