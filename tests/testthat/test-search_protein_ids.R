test_that("use", {
  Sys.sleep(2)
  ids <- search_protein_ids(accession = "4ZW9")
  expect_equal(ids, "901695856")
})

test_that("use", {
  return()
  pbd_ids <- c(
    "3GD8_1",
    "4ZW9_1",
    "5WQC_1",
    "6MBA_1",
    "5YXK_1",
    "4EIY_1",
    "6ZDR_1",
    "4AL1_1",
    "4WOL_1",
    "6PS7_1",
    "6QZI_1",
    "5WIU_1"
  )
  pbd_ids <- stringr::str_sub(pbd_ids, 1, 4)

  for (accession in pbd_ids) {
    message(accession)
    id <- search_protein_ids(accession = accession)
    message(paste0(id, collapse = " "))
    expect_true(length(id) > 0)
    Sys.sleep(2)
  }
  # Result:
  #
  # 3GD8
  # 226192721
  # 4ZW9
  # 901695856
  # 5WQC
  # 1285033761
  # 6MBA
  # 1612357152
  # 5YXK
  # 1530732204 1530732203 1530732202 1530732201
  # 4EIY
  # 399125248
  # 6ZDR
  # 1905004714
  # 4AL1
  # 448262378
  # 4WOL
  # 827343090 827343089 827343088
  # 6PS7
  # 1775480764
  # 6QZI
  # 1781382338
  # 5WIU
  # 1270516811
})
