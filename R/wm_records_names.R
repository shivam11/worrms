#' Get records for onen or more taxonomic name(s)
#'
#' @export
#' @param name (character) start date. required.
#' @param fuzzy (logical) fuzzy search. default: `FALSE`
#' @param marine_only (logical) marine only or not. default: `TRUE`
#' @template curl
#' @note there is no underscore method like other functions in this package
#' as this is the plural version for [wm_records_name()]
#' @return A list of tibble's/data.frame's, one for each of the input names
#' @examples \dontrun{
#' wm_records_names(name = 'Platanista gangetica')
#' wm_records_names(name = 'Platanista gangetica', fuzzy = TRUE)
#' wm_records_names(name = c('Platanista gangetica', 'Coryphaena'))
#' }
wm_records_names <- function(name, fuzzy = FALSE, marine_only = TRUE, ...) {
  assert(name, "character")
  assert(fuzzy, "logical")
  assert(marine_only, "logical")

  args <- cc(list(like = as_log(fuzzy), marine_only = as_log(marine_only)))
  args <- c(args,
            stats::setNames(as.list(name),
                            rep('scientificnames[]',
                                length(name))))
  wm_GET(file.path(wm_base(), "AphiaRecordsByNames"),
         query = args, ...)
}
