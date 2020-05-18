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
      '- input', wrong_input, 'is of class', wrong_classe,
      collapse = ',\n'
    )

    stop(glue("
    All the inputs must be the output of {usethis::ui_code('turn()')}.
    They are not:

    {err_msg}.

    Please use {usethis::ui_code('turn()')} to create all the inputs.
    "))
  }

  structure(list(), class = "game")
}
