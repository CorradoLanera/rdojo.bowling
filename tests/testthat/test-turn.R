test_that("turn return an object of class turn on a couple of integers", {
  expect_is(turn(1, 1), "turn")
})
