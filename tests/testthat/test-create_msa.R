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

test_that("bug report: msa::msaConvert to AAbin format results in incorrect FASTA file", { # nolint indeed a long title

  return()

  # Bug report posted at https://github.com/UBod/msa/issues/7

  # Use example code from msa::msaConvert
  filepath <- system.file("examples", "exampleAA.fasta", package = "msa")
  mySeqs <- readAAStringSet(filepath) # nolint no snake_case, as the example follows this style
  myAlignment <- msa(mySeqs) # nolint no snake_case, as the example follows this style
  msa_as_ape_aabin <- msa::msaConvert(myAlignment, "ape::AAbin")

  # Save it to file
  fasta_filename <- tempfile()
  ape::write.FASTA(x = msa_as_ape_aabin, file = fasta_filename) # Gives warnings

  # Show the file content. Below I show the output, notice there
  # are no sequences saved
  readLines(fasta_filename)
  #  [1] ">PH4H_Rattus_norvegicus"         ""
  #  [3] ">PH4H_Mus_musculus"              ""
  #  [5] ">PH4H_Homo_sapiens"              ""
  #  [7] ">PH4H_Bos_taurus"                ""
  #  [9] ">PH4H_Chromobacterium_violaceum" ""
  # [11] ">PH4H_Ralstonia_solanacearum"    ""
  # [13] ">PH4H_Caulobacter_crescentus"    ""
  # [15] ">PH4H_Pseudomonas_aeruginosa"    ""
  # [17] ">PH4H_Rhizobium_loti"            ""
  # Warning messages:
  # 1: In readLines(fasta_filename) :
  #   line 2 appears to contain an embedded nul
  # 2: In readLines(fasta_filename) :
  #   line 4 appears to contain an embedded nul
  # 3: In readLines(fasta_filename) :
  #   line 6 appears to contain an embedded nul
  # 4: In readLines(fasta_filename) :
  #   line 8 appears to contain an embedded nul
  # 5: In readLines(fasta_filename) :
  #   line 10 appears to contain an embedded nul
  # 6: In readLines(fasta_filename) :
  #   line 12 appears to contain an embedded nul
  # 7: In readLines(fasta_filename) :
  #   line 14 appears to contain an embedded nul
  # 8: In readLines(fasta_filename) :
  #   line 16 appears to contain an embedded nul
  # 9: In readLines(fasta_filename) :
  #   line 18 appears to contain an embedded nul
})
