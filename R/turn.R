#' Turn
#'
#' @param x (int) score for the first roll in the turn
#' @param y (int) score for the second roll in the turn
#'
#' @return an object of class [turn]
#' @export
#'
#' @examples
#' turn(1, 1)
turn <- function(x, y) {
  assertive::assert_is_a_number(x)
  assertive::assert_all_are_whole_numbers(x)

  assertive::assert_is_a_number(y)
  assertive::assert_all_are_whole_numbers(y)

  structure(list(), class = "turn")
}
