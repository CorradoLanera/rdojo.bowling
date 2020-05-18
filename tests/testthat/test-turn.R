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

test_that("second input could be empty (default zero)", {
  expect_equal(turn(1, 0), turn(1))
})


test_that("output is the sum of the input", {
  expect_true(turn(1) == 1)
  expect_true(turn(1, 2) ==  3)
})


test_that("Correct attribute type", {
  expect_equal(attr(turn(1), "type"), "standard")
  expect_equal(attr(turn(5, 5), "type"), "spare")
  expect_equal(attr(turn(10), "type"), "strike")
})

test_that("original rolls are retained", {
  expect_equal(attr(turn(1, 2), "rolls"), c(1, 2))
  expect_equal(attr(turn(1), "rolls"), c(1, 0))
  expect_equal(attr(turn(10), "rolls"), c(10, 0))
})


test_that("turn print nicely", {
  turn_1 <- turn(1)
  expect_equal(print(turn_1), turn_1)
  expect_output(print(turn_1), "First roll: 1")
  expect_output(print(turn_1), "Second roll: 0")
  expect_output(print(turn_1), "score: 1")
  expect_output(print(turn_1), "standard")

  strike <- turn(10)
  expect_output(print(strike), "First roll: 10")
  expect_output(print(strike), "Second roll: 0")
  expect_output(print(strike), "score: 10")
  expect_output(print(strike), "strike")

  spare <- turn(5, 5)
  expect_output(print(spare), "First roll: 5")
  expect_output(print(spare), "Second roll: 5")
  expect_output(print(spare), "score: 10")
  expect_output(print(spare), "spare")
})
