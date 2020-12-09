#' Tests if all elements are unique
#' @export
are_all_unique <- function(x) {
  testthat::expect_true(length(x) > 0)
  testthat::expect_equal(0, sum(is.na(x)))
  length(x) == length(unique(x))
}
