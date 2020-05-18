t1 <- turn(1, 2)
ts <- turn(3, 7)
tx <- turn(10)
t0 <- turn(0, 0)

test_that("game return an object of class game", {
  expect_is(expect_warning(game(t1)), "game")
  expect_is(expect_warning(game(t1, t1)), "game")
})

test_that("game trow error if not all objects are of class turn", {
  expect_error(expect_warning(game(t1, 3)), "3 is of class numeric")
  expect_error(
    expect_warning(game(t1, "foo", 3)),
    '"foo" is of class character'
  )
})


test_that("Do not collect more turns than possible", {
  expect_error(
    game(t1, t1, t1, t1, t1, t1, t1, t1, t1, t1,
         t1 # eleventh without a final spare
    ),
    "You have played 11 turns"
  )
  expect_error(
    game(t1, t1, t1, t1, t1, t1, t1, t1, t1, ts,
         t1, t1 # twelveth without two final consecutives strikes
    ),
    "You have played 12 turns"
  )
  expect_error(
    game(t1, t1, t1, t1, t1, t1, t1, t1, t1, ts,
         ts, t1 # twelveth without two final consecutives strikes
    ),
    "11th turn a spare"
  )
  expect_error(
    game(t1, t1, t1, t1, t1, t1, t1, t1, t1, ts,
         tx, t1 # twelveth without two final consecutives strikes
    ),
    "10th turn a spare"
  )
  expect_error(
    game(t1, t1, t1, t1, t1, t1, t1, t1, t1, tx,
         t1, t1 # twelveth without two final consecutives strikes
    ),
    "11th turn a standard"
  )
  expect_error(
    game(t1, t1, t1, t1, t1, t1, t1, t1, t1, tx,
         ts, t1 # twelveth without two final consecutives strikes
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
    game(t1, t1, t1, t1, t1, t1, t1, t1, t1, ts, t1),
    "game"
  )
  expect_is(
    game(t1, t1, t1, t1, t1, t1, t1, t1, t1, tx, t1),
    "game"
  )
  expect_is(
    game(t1, t1, t1, t1, t1, t1, t1, t1, t1, tx, tx, t1),
    "game"
  )
})



test_that("game() returns an ordered list of turns", {
  expect_equivalent(
    unclass(expect_warning(game(t1, t1))),
    list(t1, t1, t0, t0, t0, t0, t0, t0, t0, t0)
  )
  expect_false(expect_warning(all(
    purrr::map2_lgl(game(ts, t1), game(t1, ts), `==`)
  )))
})


test_that("
    every game has at least 10 turns (eventually compeltet with zeros
    turns and a warning)
  ", {

     expect_equivalent(
     expect_warning(game(t1), "A complete game has 10 turns."),
      game(t1, t0, t0, t0, t0, t0, t0, t0, t0, t0)
    )
    expect_equivalent(
      expect_warning(game(turn(5)), "A complete game has 10 turns."),
      game(turn(5, 0), t0, t0, t0, t0, t0, t0, t0, t0, t0)
    )
    expect_equivalent(
      expect_warning(
        game(t1, t1, t1, t1, t1, t1, t1, t1, t1, ts),
        "You finished your game with a spare/stike"
      ),
      game(t1, t1, t1, t1, t1, t1, t1, t1, t1, ts, t0)
    )
    expect_equivalent(
      expect_warning(
        game(t1, t1, t1, t1, t1, t1, t1, t1, t1, tx),
        "You finished your game with a spare/stike"
      ),
      game(t1, t1, t1, t1, t1, t1, t1, t1, t1, tx, t0)
    )
    expect_equivalent(
      expect_warning(
        game(t1, t1, t1, t1, t1, t1, t1, t1, t1, tx, tx),
        "You finished your game with a spare/stike"
      ),
      game(t1, t1, t1, t1, t1, t1, t1, t1, t1, tx, tx, t0)
    )

})



test_that("game print nicely", {
  g1 <- suppressWarnings(game(t1))
  expect_equal(print(g1), g1)
  expect_output(
    print(g1),
    "Game length: 10 turns \\(1 played \\+ 9 forfait\\)"
  )
})


test_that("expected error for extra game in acceptance test", {
  expect_error(game(tx, tx, tx, tx, tx, tx, tx, tx, tx, ts, tx, tx))
})


test_that(
  "game are printed using X for strikes, / for spares, - for 0s", {

    g1 <- suppressWarnings(game(turn(1)))
    expect_output(print(g1), "|1- -- -- -- -- -- -- -- -- --|-- --|")

    gx <- game(tx, tx, tx, tx, tx, tx, tx, tx, tx, tx, tx, tx)
    expect_output(print(g1), "|X  X  X  X  X  X  X  X  X  X |X  X |")

    gs <- game(ts, ts, ts, ts, ts, ts, ts, ts, ts, ts, turn(5))
    expect_output(print(g1), "|5/ 5/ 5/ 5/ 5/ 5/ 5/ 5/ 5/ 5/|5- --|")

    g_all <- game(
      turn(1, 2), turn(2, 3), turn(3, 4), turn(4, 5), turn(3, 6),
      turn(2, 7), turn(1, 8), turn(0, 9), turn(9, 1), turn(10), turn(1)
    )
    expect_output(print(g1), "|12 23 34 45 56 67 78 89 9/ X |1- --|")

  }
)
