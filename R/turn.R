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
turn <- function(x, y = 0L) {
  assertive::assert_is_a_number(x)
  assertive::assert_all_are_whole_numbers(x)

  assertive::assert_is_a_number(y)
  assertive::assert_all_are_whole_numbers(y)

  assertive::assert_all_are_greater_than_or_equal_to(x, 0)
  assertive::assert_all_are_greater_than_or_equal_to(y, 0)
  assertive::assert_all_are_less_than_or_equal_to(x + y, 10)

  x <- as.integer(x)
  y <- as.integer(y)

  score <- x + y

  rolls <- c(x, y)

  type <- if (x == 10L) {
    "strike"
  } else if (score == 10L) {
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

get_roll <- function(turn, n) {
  UseMethod("get_roll", turn)
}

get_roll.turn <- function(turn, n = c(1, 2)) {
  n <- match.arg(as.character(n), choices = c("1", "2")) %>%
    as.integer()

  attr(turn, "rolls")[[n]]
}

render <- function(x) {
  UseMethod("render", x)
}

render.turn <- function(x) {
  marks <- c(
    `0` = "-", `1` = "1", `2` = "2", `3` = "3", `4` = "4", `5` = "5",
    `6` = "6", `7` = "7", `8` = "8", `9` = "9", `10` = "X"
  )

  r1 <- marks[as.character(get_roll(x, 1))]
  r2 <- switch(get_type(x),
               standard = marks[as.character(get_roll(x, 2))],
               spare = "/",
               strike = " "
  )

  paste0(r1, r2)
}
