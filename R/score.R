#' Evaluate a complete score for a turn
#'
#' @param game a [game]
#' @param n_turn (int) number of turn to evaluate the score (between
#'   1 and 10)
#'
#' @return (int) the score for the `n_turn`th turn of the game
#' @export
#'
#' @examples
#' game <- game(turn(5, 5), turn(2, 5))
#' eval_score_turn(game, 1) # 12
eval_score_turn <- function(game, n_turn) {
  turn <- game[[n_turn]]
  turn_type <- get_type(turn)

  res <- switch(turn_type,
    standard = turn[[1]],
    spare    = turn[[1]] + get_roll(game[[n_turn + 1]], 1),
    strike   = turn[[1]] + eval_score_turn(game, n_turn + 1)
  )

  res


}
