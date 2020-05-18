#' Create game object
#'
#' A game is a sequence of [turn]s.
#'
#' @note The order of the turns matter!
#'
#' @param ... turns to include in the game
#'
#' @return an object of class [game]
#' @export
#'
#' @examples
#' t1 <- turn(1, 2)
#' game(t1)
#' game(t1, t1)
game <- function(...) {
  structure(list(), class = "game")
}
