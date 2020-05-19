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

  assertive::assert_all_are_greater_than_or_equal_to(n_turn, 1L)
  assertive::assert_all_are_less_than_or_equal_to(n_turn, 10L)
  assertive::assert_is_a_number(n_turn)
  assertive::assert_all_are_whole_numbers(n_turn)


  turn <- game[[n_turn]]
  turn_type <- get_type(turn)

  second_turn <- turn_type == "strike" &&
                 get_type(game[[n_turn  + 1L]]) == "strike"

  switch(turn_type,
    standard = turn[[1L]],
    spare    = turn[[1L]] + get_roll(game[[n_turn + 1L]], 1L),
    strike   = turn[[1L]] +
               game[[n_turn + 1L]][[1L]] +
               ifelse(second_turn,
                 get_roll(game[[n_turn + 2L]], 1L),
                 0L
               )
  )
}
