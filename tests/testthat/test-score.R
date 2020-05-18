test_that("Compute real score for a turn", {
  g1 <- suppressWarnings(
    game(turn(1, 1), turn(5, 5), turn(3, 4), turn(10), turn(4, 3))
  )

  expect_equal(eval_score_turn(g1, 1), 2)
  expect_equal(eval_score_turn(g1, 2), 13)
  expect_equal(eval_score_turn(g1, 4), 17)
})


test_that("Compute real score for complex turns", {
  g1 <- suppressWarnings(
    game(turn(10), turn(10), turn(10), turn(10))
  )
  expect_equal(eval_score_turn(g1, 1), 30)
  expect_equal(eval_score_turn(g1, 2), 30)

  g2 <- suppressWarnings(
    game(turn(5, 5), turn(10), turn(10), turn(10))
  )
  expect_equal(eval_score_turn(g2, 1), 20)

  g3 <- suppressWarnings(
    game(turn(10), turn(10), turn(5, 3))
  )
  expect_equal(eval_score_turn(g3, 1), 25)
})


test_that("cannot compute score for extra turns", {
  tx <- turn(10)
  gx <- game(tx, tx, tx, tx, tx, tx, tx, tx, tx, tx, tx, tx)

  expect_error(eval_score_turn(gx, 11), "less than or equal to 10")
  expect_error(eval_score_turn(gx, 12), "less than or equal to 10")
})

test_that("turns must be a (single) positive integer", {
  g1 <- suppressWarnings(game(turn(1)))

  expect_error(eval_score_turn(gx, 0), "greater than or equal to 1")
  expect_error(eval_score_turn(gx, 1.5), "not all whole numbers")
  expect_error(
    eval_score_turn(gx, c(1, 2)),
    "n_turn has length 2, not 1"
  )
})
