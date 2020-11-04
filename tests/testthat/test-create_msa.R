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

  # https://github.com/richelbilderbeek/reports/issues/1
  # This is the FASTA text of the protein sequences we work on
  fasta_text <- c(
    ">A",
    "TIGSFQFGYNTGVINAPEKIIKEFITKTLTD",
    ">B",
    "IGSFQFGYNTGVINAPEKIIKEFITKTLT"
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
  # x[2]: "TIGSFQFGYNTGVINAPEKIIKEFITKTLTDNANANANANANANANANANANANANANANANANANANANANANANANANANANANANA"
  # y[2]: "TIGSFQFGYNTGVINAPEKIIKEFITKTLTD"
  #
  # x[4]: "IGSFQFGYNTGVINAPEKIIKEFITKTLTNANANANANANANANANANANANANANANANANANANANANANANANANANANANANANANA"
  # y[4]: "IGSFQFGYNTGVINAPEKIIKEFITKTLT"
  expect_error(
    expect_equal(
      readr::read_lines(file = fasta_filename),
      fasta_text
    )
  )
})

test_that("bug report: msa::msaConvert to seqinr format results in incorrect FASTA file", { # nolint indeed a long title

  return()
  # Reported at https://github.com/UBod/msa/issues/6
  # This is the FASTA text of the protein sequences we work on
  fasta_text <- c(
    ">A",
    "TIGSFQFGYNTGVINAPEKIIKEFITKTLTD",
    ">B",
    "IGSFQFGYNTGVINAPEKIIKEFITKTLT"
  )

  # Save it to a file
  fasta_filename <- tempfile()
  readr::write_lines(x = fasta_text, file = fasta_filename)

  # Of course, reading that file results in the original FASTA file text
  expect_equal(
    readr::read_lines(file = fasta_filename),
    fasta_text
  )

  ##################################################
  # Here we prove that the problem is not in seqinr
  ##################################################
  #
  # Now we load the file again using seqinr
  alignment <- seqinr::read.fasta(file = fasta_filename, seqtype = "AA")

  # The alignment has the correct lengths
  expect_equal(length(alignment$A), nchar(fasta_text[2]))
  expect_equal(length(alignment$B), nchar(fasta_text[4]))

  # Now we save that alignment again to a FASTA file using seqinr
  seqinr::write.fasta(
    sequences = alignment,
    names = names(alignment),
    file.out = fasta_filename
  )

  # Great, saving and loading with seqinr works!
  expect_equal(
    readr::read_lines(file = fasta_filename),
    fasta_text
  )

  ############################################################
  # Here we save and load an alignment after calling msa::msa
  ############################################################
  alignment <- msa::msa(
    inputSeqs = Biostrings::readAAStringSet(fasta_filename)
  )

  # The alignment is correct
  expect_equal(unname(as.character(alignment)[1]), fasta_text[2])
  expect_equal(
    unname(as.character(alignment)[2]),
    paste0("-", fasta_text[4], "-") # Indeed, the second sequence was shorter
  )

  # Convert the alignment to seqinr format, works great!
  msa_as_seqinr_alignment <- msa::msaConvert(alignment, "seqinr::alignment")
  expect_equal(msa_as_seqinr_alignment$seq[1], fasta_text[2])
  expect_equal(
    msa_as_seqinr_alignment$seq[2],
    paste0("-", fasta_text[4], "-") # Indeed, the second sequence was shorter
  )

  # Save to file, here things go wrong
  seqinr::write.fasta(
    sequences = msa_as_seqinr_alignment$seq,
    names = names(sequences),
    file.out = fasta_filename
  )

  # Hand-craft the aligned FASTA text
  # (note that this does not matter much for this bug)
  aligned_fasta_text <- fasta_text
  aligned_fasta_text[4] <- paste0("-", fasta_text[4], "-")

  # The saved file has only three lines
  #
  # Error: readr::read_lines(file = fasta_filename) not equal to `fasta_text`.
  # Lengths differ: 3 is not 4
  #
  # Printing the saved file shows the problem:
  #
  # > readr::read_lines(file = fasta_filename)
  # [1] ">A"
  # [2] ">B"
  # [3] "TIGSFQFGYNTGVINAPEKIIKEFITKTLTD-IGSFQFGYNTGVINAPEKIIKEFITKTLT-"
  #
  # The problem is that the two sequences are both saved at the end, in one line
  #
  expect_equal(
    readr::read_lines(file = fasta_filename),
    aligned_fasta_text
  )

})


test_that("bug report: msa::msaConvert to AAbin format results in incorrect FASTA file", { # nolint indeed a long title

  return()

  # Bug report posted at https://github.com/UBod/msa/issues/7

  # Use example code from msa::msaConvert
  filepath <- system.file("examples", "exampleAA.fasta", package = "msa")
  mySeqs <- readAAStringSet(filepath)
  myAlignment <- msa(mySeqs)
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
