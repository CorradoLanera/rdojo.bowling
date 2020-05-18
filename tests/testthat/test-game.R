test_that("game return an object of class game", {
  t1 <- turn(1, 2)
  expect_is(game(t1), "game")
})
