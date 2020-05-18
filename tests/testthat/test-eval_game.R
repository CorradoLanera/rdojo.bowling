test_that("Overall score are correctly compted", {
  t1 <- turn(1)
  g1 <- suppressWarnings(game(t1))
  g10 <- game(t1, t1, t1, t1, t1, t1, t1, t1, t1, t1)
  expect_equal(eval_game(g1), 1)
  expect_equal(eval_game(g10), 10)


  tx <- turn(10)
  gx <- game(tx, tx, tx, tx, tx, tx, tx, tx, tx, tx, tx, tx)
  expect_equal(eval_game(gx), 300)

  ts <- turn(5, 5)
  gs <- game(ts, ts, ts, ts, ts, ts, ts, ts, ts, ts, ts)
  expect_equal(eval_game(gs), 150)

  t9 <- turn(9)
  g9 <- game(t9, t9, t9, t9, t9, t9, t9, t9, t9, t9)
  expect_equal(eval_game(g9), 90)

  g5 <- suppressWarnings(game(turn(5, 5), turn(5)))
  expect_equal(eval_game(g5), 20)

  g5 <- suppressWarnings(game(turn(5, 5), turn(5, 0)))
  expect_equal(eval_game(g5), 20)
})
