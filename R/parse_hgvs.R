#' Parse a HGVS variation description
#' @inheritParams default_params_doc
#' @note see \url{http://varnomen.hgvs.org/} for the HGVS format
#' @return the variation as a list
#' @export
parse_hgvs <- function(s) {
  testthat::expect_true(length(s) == 1)
  frame_shift_match <- stringr::str_subset(
    s, "^.*:p.[A-Z][a-z]{1,2}[[:digit:]]+fs$"
  )
  if (length(frame_shift_match) != 0) {
    stop("Do not accept frame shifts, in sequence '", s, "'")
  }
  extensions_shift_match <- stringr::str_subset(
    s, "^.*:p\\..*ext.*$"
  )
  if (length(extensions_shift_match) != 0) {
    stop("Do not accept extensions, in sequence '", s, "'")
  }
  delins_match <- stringr::str_subset(
    s, "^.*:p\\..*delins.*$"
  )
  if (length(delins_match) != 0) {
    stop("Do not accept delins, in sequence '", s, "'")
  }
  ins_match <- stringr::str_subset(
    s, "^.*:p\\..*ins.*$"
  )
  if (length(ins_match) != 0) {
    stop("Do not accept insertions, in sequence '", s, "'")
  }
  del_match <- stringr::str_subset(
    s, "^.*:p\\..*del$"
  )
  if (length(del_match) != 0) {
    stop("Do not accept deletions, in sequence '", s, "'")
  }
  dup_match <- stringr::str_subset(
    s, "^.*:p\\..*dup$"
  )
  if (length(dup_match) != 0) {
    stop("Do not accept duplications, in sequence '", s, "'")
  }

  rep_seq_match <- stringr::str_subset(
    s, "^.*:p\\..*_.*$"
  )
  if (length(rep_seq_match) != 0) {
    stop("Do not accept repeated sequences, in sequence '", s, "'")
  }


  m <- stringr::str_match(
    s, "^(.*):p.([A-Z][a-z]{1,2})([[:digit:]]+)(\\=|[A-Z][a-z]{1,2})$")
  variation <- list(
    name = m[1, 2],
    pos = as.numeric(m[1, 4]),
    from = m[1, 3],
    to = m[1, 5]
  )
  if (variation$to == "=") {
    variation$to <- variation$from
  }
  variation
}
