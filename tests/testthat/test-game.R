t1 <- turn(1, 2)
t_spare <- turn(3, 7)
t_strike <- turn(10)
t0 <- turn(0, 0)

test_that("game return an object of class game", {
  expect_is(game(t1), "game")
  expect_is(game(t1, t1), "game")
})

test_that("game trow error if not all objects are of class turn", {
  expect_error(game(t1, 3), "3 is of class numeric")
  expect_error(game(t1, "foo", 3), '"foo" is of class character')
})


test_that("Do not collect more turns than possible", {
  expect_error(
    game(t1, t1, t1, t1, t1, t1, t1, t1, t1, t1,
         t1 # eleventh without a final spare
    ),
    "You have played 11 turns"
  )
  expect_error(
    game(t1, t1, t1, t1, t1, t1, t1, t1, t1, t_spare,
         t1, t1 # twelveth without two final consecutives strikes
    ),
    "You have played 12 turns"
  )
  expect_error(
    game(t1, t1, t1, t1, t1, t1, t1, t1, t1, t_spare,
         t_spare, t1 # twelveth without two final consecutives strikes
    ),
    "11th turn a spare"
  )
  expect_error(
    game(t1, t1, t1, t1, t1, t1, t1, t1, t1, t_spare,
         t_strike, t1 # twelveth without two final consecutives strikes
    ),
    "10th turn a spare"
  )
  expect_error(
    game(t1, t1, t1, t1, t1, t1, t1, t1, t1, t_strike,
         t1, t1 # twelveth without two final consecutives strikes
    ),
    "11th turn a standard"
  )
  expect_error(
    game(t1, t1, t1, t1, t1, t1, t1, t1, t1, t_strike,
         t_spare, t1 # twelveth without two final consecutives strikes
    ),
    "11th turn a spare"
  )
})


test_that("Accept the maximum number of turns required", {
  expect_is(
    game(t1, t1, t1, t1, t1, t1, t1, t1, t1, t1),
    "game"
  )
  expect_is(
    game(t1, t1, t1, t1, t1, t1, t1, t1, t1, t_spare, t1),
    "game"
  )
  expect_is(
    game(t1, t1, t1, t1, t1, t1, t1, t1, t1, t_strike, t1),
    "game"
  )
  expect_is(
    game(t1, t1, t1, t1, t1, t1, t1, t1, t1, t_strike, t_strike, t1),
    "game"
  )
})



test_that("game() returns an ordered list of turns", {
  expect_equivalent(
    unclass(game(t1, t1)),
    list(t1, t1)
  )
  expect_false(all(
    purrr::map2_lgl(game(t_spare, t1), game(t1, t_spare), `==`)
  ))
})
