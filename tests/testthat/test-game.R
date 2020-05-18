t1 <- turn(1, 2)

test_that("game return an object of class game", {
  expect_is(game(t1), "game")
  expect_is(game(t1, t1), "game")
})

test_that("game trow error if not all objects are of class turn", {
  expect_error(game(t1, 3))
})
