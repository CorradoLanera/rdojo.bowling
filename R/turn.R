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
turn <- function(x, y = 0) {
  assertive::assert_is_a_number(x)
  assertive::assert_all_are_whole_numbers(x)

  assertive::assert_is_a_number(y)
  assertive::assert_all_are_whole_numbers(y)

  assertive::assert_all_are_greater_than_or_equal_to(x, 0)
  assertive::assert_all_are_greater_than_or_equal_to(y, 0)
  assertive::assert_all_are_less_than_or_equal_to(x+y, 10)

  structure(x + y, class = "turn")
}
