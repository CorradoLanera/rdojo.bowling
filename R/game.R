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

  inputs <- rlang::list2(...)
  inputs <- purrr::set_names(inputs, glue("turn {seq_along(inputs)}"))

  are_turns <- purrr::map_lgl(inputs, inherits, "turn")

  if (!all(are_turns)) {
    wrong_input <- inputs_name[!are_turns]
    wrong_classe <- purrr::map_chr(inputs[!are_turns], class)
    err_msg <- paste(
      "  - input", wrong_input, "is of class", wrong_classe,
      collapse = ",\n"
    )

    stop(glue("
    All the inputs must be the output of {usethis::ui_code('turn()')}.
      They are not:

    {err_msg}.

      Please use {usethis::ui_code('turn()')} to create all the inputs.
    "))
  }

  game_len <- length(inputs)

  if (game_len > 10L && get_type(inputs[[10L]]) == "standard") {
    stop(glue("
    If your 10th turn is a standard turn, it must be the last turn.

      You have played {game_len} turns ({game_len - 10L} exceeding).

      Please play a regular game.
    "))
  }

  if (game_len > 11L &&
       (
         get_type(inputs[[10L]]) != "strike" ||
         get_type(inputs[[11L]]) != "strike"
       )
  ) {
    stop(glue("
    You can play up to 12 turns (if 10th and 11th are both strikes).

      You have played {game_len} turns with:
      - 10th turn a {get_type(inputs[[10L]])} and
      - 11th turn a {get_type(inputs[[11L]])}.

      Please play a regular game.
    "))
  }


  to_complete <- FALSE

  if (game_len < 10L) {
    warning(glue("
    You have played {game_len} turns only.

      A complete game has 10 turns. The {10L - game_len} missing turns
      will be all considered with a 0 score each rolls.
    "))
    to_complete <- TRUE

  } else if (

    (game_len == 10L && get_type(inputs[[10L]]) != "standard") ||
    (
      game_len == 11L &&
      get_type(inputs[[10L]]) == "strike" &&
      get_type(inputs[[11L]]) == "strike"
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
    missing_turns <- seq_len(max(10L, game_len + 1L)) %>%
      setdiff(seq_len(game_len))
    missing_turns <- purrr::set_names(
      missing_turns, paste("turn", missing_turns)
    )

    game_empty <- turn(0L, 0L)

    inputs <- c(
      inputs,
      purrr::map(missing_turns, ~game_empty)
    )
  }


  structure(inputs,
    game_length = length(inputs),
    turns_played = game_len,
    forfait = to_complete,
    class = "game"
  )
}





#' Print method for turn object
#'
#' @param x an object of class [game]
#' @param ... further arguments passed to or from other methods
#'   (currently unused)
#'
#' @return x invisibly
#' @importFrom glue glue
#' @export
print.game <- function(x, ...) {

  played <- attr(x, "turns_played")
  turns <- attr(x, "game_length")
  forfait <- attr(x, "forfait")

  info <- ""
  if (forfait) {
    info <- glue(" ({played} played + {turns - played} forfait)")
  }

  normal  <- paste(purrr::map_chr(x[1:10], render.turn), collapse = " ")
  extra <- purrr::map_chr(x[-(1:10)], render.turn) %>%
    paste(collapse = " ") %>%
    stringr::str_pad(5, "right")

  cli::cat_rule(glue("Game length: {turns} turns{info}"))
  cli::cat_boxx(paste0("|", normal, "|", extra, "|"))

  invisible(x)
}



