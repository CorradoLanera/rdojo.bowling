test_that("turn return an object of class turn on a couple of integers", {

  # output class
  expect_is(turn(1, 1), "turn")

  # input classes
  expect_error(turn(1, "1"), "it has class 'character'")
  expect_error(turn("1", 1), "it has class 'character'")
  expect_error(turn(1.5, 1), "x are not all whole numbers")
  expect_error(turn(1, 1.5), "y are not all whole numbers")
})


test_that("inputs are single positive numbers", {
  expect_error(turn(c(1, 2), 1), "x has length 2, not 1")
  expect_error(turn(1, c(1, 2)), "y has length 2, not 1")
})


test_that("inputs are between 0 and 10 (sum included)", {
  expect_error(turn(-1, 1))
  expect_error(turn(1, -1))
  expect_error(turn(11, 1))
  expect_error(turn(1, 11))
  expect_error(turn(9, 2))
})
