#' Turn
#'
#' @param x (int) score for the first roll in the turn
#' @param y (int, default 0) score for the second roll in the turn
#'
#' @return an object of class [turn] reporting:
#'   - the sum of the rolls
#'   - the original rolls
#'   - the type of turn (standard, spare, or strike)
#'
#' @export
#'
#' @examples
#' turn(1, 1) # 2, standard
#' turn(1)    # 1, standard
#' turn(5, 5) # 10, spare
#' turn(10)   # 10, strike
turn <- function(x, y = 0) {
  assertive::assert_is_a_number(x)
  assertive::assert_all_are_whole_numbers(x)

  assertive::assert_is_a_number(y)
  assertive::assert_all_are_whole_numbers(y)

  assertive::assert_all_are_greater_than_or_equal_to(x, 0)
  assertive::assert_all_are_greater_than_or_equal_to(y, 0)
  assertive::assert_all_are_less_than_or_equal_to(x + y, 10)

  score <- x + y

  rolls <- c(x, y)

  type <- if (x == 10) {
    "strike"
  } else if (score == 10) {
    "spare"
  } else {
    "standard"
  }

  structure(score,
    rolls = rolls,
    type = type,
    class = "turn"
  )
}


#' Print method for turn object
#'
#' @param x an object of class [turn]
#' @param ... further arguments passed to or from other methods
#'   (currently unused)
#'
#' @return x invisibly
#' @importFrom glue glue
#' @export
print.turn <- function(x, ...) {

  type <- attr(x, "type")

  cli::cat_rule(glue("Turn's score: {x} ({type})"))
  cli::cat_bullet(glue("First roll: {attr(x, 'rolls')[[1]]}"))
  cli::cat_bullet(glue("Second roll: {attr(x, 'rolls')[[2]]}"))

  invisible(x)
}

get_type <- function(x) {
  UseMethod("get_type", x)
}

get_type.turn <- function(x) {
  attr(x, "type")
}
