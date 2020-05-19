#' Eval the overall score of a game
#'
#' @param g a [game] object.
#'
#' @return (int) the overall score of g
#' @export
#'
#' @examples
#' t1 <- turn(1)
#' g1 <- game(t1)
#' eval_game(g1) # 1
eval_game <- function(g) {
  purrr::map_int(1:10, eval_score_turn, game = g) %>%
    sum()
}
