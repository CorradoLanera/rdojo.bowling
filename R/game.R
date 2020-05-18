#' Create game object
#'
#' A game is a sequence of [turn]s.
#'
#' @note The order of the turns matter!
#'
#' @param ... turns to include in the game
#'
#' @importFrom glue glue
#'
#' @return an object of class [game]
#' @export
#'
#' @examples
#' t1 <- turn(1, 2)
#' game(t1)
#' game(t1, t1)
game <- function(...) {

  inputs_name <- rlang::enexprs(...) %>%
    purrr::map_chr(rlang::as_label)

  inputs <- rlang::list2(...) %>%
    purrr::set_names(glue("turn {seq_along(.)}"))

  are_turns <- purrr::map_lgl(inputs, inherits, "turn")

  if (!all(are_turns)) {
    wrong_input <- inputs_name[!are_turns]
    wrong_classe <- purrr::map_chr(inputs[!are_turns], class)
    err_msg <- paste(
      '  - input', wrong_input, 'is of class', wrong_classe,
      collapse = ',\n'
    )

    stop(glue("
    All the inputs must be the output of {usethis::ui_code('turn()')}.
      They are not:

    {err_msg}.

      Please use {usethis::ui_code('turn()')} to create all the inputs.
    "))
  }

  game_len <- length(inputs)

  if (game_len > 10 && get_type(inputs[[10]]) == "standard") {
    stop(glue("
    If your 10th turn is a standard turn, it must be the last turn.

      You have played {game_len} turns (which are {game_len - 10} more than allowed).

      Please play a regular game.
    "))
  }

  if (game_len > 11 &&
       (
         get_type(inputs[[10]]) != "strike" ||
         get_type(inputs[[11]]) != "strike"
       )
  ) {
    stop(glue("
    You can play 12 turns at maximum, and only if your 10th and 11th games are both strikes.

      You have played {game_len} turns with:
      - 10th turn a {get_type(inputs[[10]])} and
      - 11th turn a {get_type(inputs[[11]])}.

      Please play a regular game.
    "))
  }


  to_complete <- FALSE

  if (game_len < 10) {
    warning(glue("
    You have played {game_len} turns only.

      A complete game has 10 turns. The {10 - game_len} missing turns
      will be all considered with a 0 score each rolls.
    "))
    to_complete <- TRUE

  } else if (

    (game_len == 10 && get_type(inputs[[10]]) != "standard") ||
    (
      game_len == 11 &&
      get_type(inputs[[10]]) == "strike" &&
      get_type(inputs[[11]]) == "strike"
    )
  ) {
    warning(glue("
    You finished your game with a spare/stike without play some of
    the bouns rolls.

    All the missing rolls will be considered with a 0 score.
    "))
    to_complete <- TRUE
  }

  if (to_complete) {
    missing_turns <- seq_len(max(10, game_len + 1)) %>%
      setdiff(seq_len(game_len)) %>%
      purrr::set_names(paste("turn", .))

    game_empty <- turn(0, 0)

    inputs <- c(
      inputs,
      purrr::map(missing_turns, ~game_empty)
    )
  }


  structure(inputs, class = "game")
}
