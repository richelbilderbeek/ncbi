test_that("use", {
  fasta_text <- c(
    ">A",
    "TIGSFQFGYNTGVINAPEKIIKEFITKTLTD",
    ">B",
    "IGSFQFGYNTGVINAPEKIIKEFITKTLT"
  )
  aligned_fasta_text <- create_msa(fasta_text)
  expect_equal(
    aligned_fasta_text,
    c(
      ">A",
      "TIGSFQFGYNTGVINAPEKIIKEFITKTLTD",
      ">B",
      "-IGSFQFGYNTGVINAPEKIIKEFITKTLT-"
    )
  )
})

test_that("bug report: bios2mds::export.fasta adds NAs", {

  return()
  # https://github.com/richelbilderbeek/reports/issues/1
  # This is the FASTA text of the protein sequences we work on
  library(testthat)
  devtools::install_version(
    "bios2mds", version = "1.2.2",
    repos = "http://cran.us.r-project.org"
  )

  # Need either
  #
  # * R 4.0.0 and bios2mds 1.2.3
  # * R 3.6.3 and bios2mds 1.2.2
  #

  # Use an aligned sequence, as suggested by Marie
  fasta_text <- c(
    ">A",
    "TIGSFQFGYNTGVINAPEKIIKEFITKTLTD",
    ">B",
    "-IGSFQFGYNTGVINAPEKIIKEFITKTLT-"
  )

  # Save it to a file
  fasta_filename <- tempfile()
  readr::write_lines(x = fasta_text, file = fasta_filename)

  # Of course, reading that file results in the original FASTA file text
  expect_equal(
    readr::read_lines(file = fasta_filename),
    fasta_text
  )

  # Now we load the file again
  alignment <- bios2mds::import.fasta(file = fasta_filename)

  # The alignment has the correct lengths
  expect_equal(length(alignment$A), nchar(fasta_text[2]))
  expect_equal(length(alignment$B), nchar(fasta_text[4]))

  # Now we save that alignment again to a FASTA file
  bios2mds::export.fasta(alignment, outfile = fasta_filename)

  # Bug: reading that file does not result in the original FASTA file text
  # Instead NAs are added at the end:
  #
  # Error: readr::read_lines(file = fasta_filename) not equal to `fasta_text`.
  # 2/4 mismatches
  # x[2]: "TIGSFQFGYNTGVINAPEKIIKEFITKTLTDNANANANANANANANANANANANANANANANANANANANANANANANANANANANANA" # nolint this is not commented code
  # y[2]: "TIGSFQFGYNTGVINAPEKIIKEFITKTLTD"                                                           # nolint this is not commented code
  #
  # x[4]: "IGSFQFGYNTGVINAPEKIIKEFITKTLTNANANANANANANANANANANANANANANANANANANANANANANANANANANANANANANA" # nolint this is not commented code
  # y[4]: "IGSFQFGYNTGVINAPEKIIKEFITKTLT"                                                               # nolint this is not commented code
  expect_equal(
    readr::read_lines(file = fasta_filename),
    fasta_text
  )

  message(paste0(devtools::session_info(), collapse = "\n"))
})
