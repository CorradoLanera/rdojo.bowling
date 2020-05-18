test_that("Compute real score for a turn", {
  g1 <- suppressWarnings(
    game(turn(1, 1), turn(5, 5), turn(3, 4), turn(10), turn(4, 3))
  )

  expect_equal(eval_score_turn(g1, 1), 2)
  expect_equal(eval_score_turn(g1, 2), 13)
  expect_equal(eval_score_turn(g1, 4), 17)
})
