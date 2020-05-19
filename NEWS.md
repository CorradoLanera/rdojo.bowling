# rdojo.bowling 1.0.0

* `game` show the overall score when printed (#6).
* Fancy print for a `game`s objects, showing the sequences of rolls
  grouped in `turn`s using symbols for interesting scores, ie "-" for 0,
  "/" for spare, and "X" for strike. The game is 10+2 turns bounded by
  "|"s (#1).
* `eval_game()` compute the overall score of a game (#6).

# rdojo.bowling 0.4.0

* `eval_score_turn()` evaluate the "actual" score for a single turn in
  a game (#6).

# rdojo.bowling 0.3.0

* `game()` prints the number of turns and (if it is a forfait game) the
  number of really played and the number of added `turn(0, 0)` (#4).
* `game()` stores if the number of turns is the game, if it is a
  forfait game, and the number or _really played_ turns (#4).
* `game()` return the sequences of turns, eventually added with 
  `turn(0, 0)` if some turns are missing (#4).
* `game()` can accept an arbitrary number of **turn** objects, given
  that they represent a valid (possibly forfait) game (#4).
* `game()` defined to store the sequence of turns in a game (#4).

# rdojo.bowling 0.2.0

* `turn()` print its output showing the overall and rolls scores, and
  the turns' type (#2).
* `turn()` stores the correct type of turns, ie standard, spare, or
  strike (#2).
* `turn()` returns overall score, and retain individual rolls' scores
   (#2).
* `turn()` can accept one or two single integer arguments (default for
  the second is 0) which individually and in sum must be included in
  [0-1] (#2).
* `turn()` defined to store turn's rolls (#2).

# rdojo.bowling 0.1.0

* Update README with project structure, usage, installation, description
  of the problem and credits.
* Providing basic development support (see `DEVELOP-SETUP.R`).

# rdojo.bowling 0.0.0.9000

* Added a `NEWS.md` file to track changes to the package.
