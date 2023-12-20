#' wrapper around glue::glue()
#'
F <- glue::glue

#' wrapper around gsub()
#'
#' @details
#' A wrapper around gsub, in order to make it usable with native pipe `|>`
#'
#' @param text CHAR. the text to be substituted
#' @param arg1 CHAR. the argument to be substituted
#' @param arg2 CHAR. the argument with the substitution
#' @param ic BOOLEAN. ignore case. Default = TRUE
#' @examples
#' "foo foo FOO bar bar" |> gsub2("foo", "fool")
gsub2 <- function(text, arg1, subs2, ic = T){
  gsub(arg1, subs2, text, ignore.case = ic)
}
