test_that("turn return an object of class turn on a couple of integers", {

  # output class
  expect_is(turn(1, 1), "turn")

  # input classes
  expect_error(turn(1, "1")) # char
  expect_error(turn("1", 1))
  expect_error(turn(1.5, 1)) # not integer-like
  expect_error(turn(1, 1.5))

})
