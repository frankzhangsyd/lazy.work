#' Generate formula strings for Alteryx
#'
#' Genetate a string which can be copied into Alteryx formula tool
#' @param x a vecotr of column names in Alteryx
#' @param f the function will be applied across columns. Default is "+"
#' @return a single string which can be copied into Alteryx formula
#' @export
#' @examples
#' fields <- c("a", "b", "c", "d")
#' ayx_fl(fields,"+")

ayx_fl <- function(x,f=c("+","-","*","/")){
  stopifnot(is.character(x))
  f <- match.arg(f)
  paste(paste0("[",x,"]"),collapse = f)
}
